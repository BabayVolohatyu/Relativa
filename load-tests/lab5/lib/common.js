// Lab 5 - shared building blocks of the k6 load scenarios (High Load Systems course).
//
// Every scenario file (scenario-a-read.js, scenario-b-write.js, scenario-c-mixed.js, staged-demo.js) imports the two
// operations below, so the request is IDENTICAL no matter which profile drives it:
//   readGraph()    - GET  /api/v1/graph?organizationId=N                        (the heaviest read of the system)
//   createEntity() - POST /api/v1/workspaces/W/entity-graph/create              (the only write endpoint of Graph;
//                                                                                Graph -> RabbitMQ RPC -> Core -> PostgreSQL)
//
// MEASUREMENT WINDOW. A run is  ramp-up (0 -> VUS over RAMP_S seconds, NOT measured)  +  hold (DURATION seconds, measured).
// Only requests that finish during the hold are written to the custom metrics m_* below; the reports are built from them.
// Why a ramp: with an instant start of 100-200 VUs the first second opens 100-200 TCP connections at once through Docker
// Desktop's port forwarding, and about half of them are reset or hang for 30 s (seen in attempt 1, evidence/lab5/k6/
// attempt1-burst-start). That is an artefact of the load generator path, not of the system under test, and it polluted
// avg/p99/error rate. The ramp is also the "warm-up" of the lab (pools, JIT, caches fill while VUs are added).
//
// Environment overrides (k6 -e NAME=value):
//   BASE_URL     entry point, default http://localhost:8090  (nginx, Round Robin, 3 Graph instances; Lab 3 topology)
//   USER_ID      value of the X-User-Id header, default 1     (seeded org_owner of organization 1; Graph trusts this header,
//                                                              in the real stack the Gateway sets it after JWT validation)
//   ORG_ID       organization for the read, default 1         (183 nodes, 291 edges, about 68 KB of JSON)
//   WORKSPACE_ID workspace for the write, default 1
//   THINK_MS     think time between requests in ms, default 500
//   RAMP_S       ramp-up seconds (not measured), default 15

import http from 'k6/http';
import exec from 'k6/execution';
import { check, sleep } from 'k6';
import { Counter, Trend } from 'k6/metrics';

export const BASE_URL = __ENV.BASE_URL || 'http://localhost:8090';
const USER_ID = __ENV.USER_ID || '1';
const ORG_ID = __ENV.ORG_ID || '1';
const WORKSPACE_ID = __ENV.WORKSPACE_ID || '1';
export const THINK_S = (parseInt(__ENV.THINK_MS || '500', 10)) / 1000;
export const RAMP_S = parseInt(__ENV.RAMP_S || '15', 10);

// Body of the create call. entityTypeId 1 = "client"; property 1 = first_name, property 3 = last_name (required).
// The marker value "Lab5WriteTest" is what the run script uses to count and archive the created entities afterwards.
const CREATE_BODY = JSON.stringify({
  entityTypeId: 1,
  properties: [
    { propertyId: 1, value: 'Lab5WriteTest' },
    { propertyId: 3, value: 'Probe' },
  ],
});

// ---- metrics of the measurement window (hold only) ----
export const mReqs = new Counter('m_reqs');          // requests finished in the window
export const mFailed = new Counter('m_failed');      // ... of which status != 200 (incl. timeouts / resets: status 0)
export const mDur = new Trend('m_dur', true);        // latency of ALL of them (a 30 s timeout counts as 30 s)
export const mDurOk = new Trend('m_dur_ok', true);   // latency of the successful ones only
const durationRead = new Trend('duration_read', true);
const durationWrite = new Trend('duration_write', true);

// Which instance answered (X-Instance-ID header; with Round Robin each of the three gets about one third).
const servedByGraph1 = new Counter('served_by_graph_1');
const servedByGraph2 = new Counter('served_by_graph_2');
const servedByGraph3 = new Counter('served_by_graph_3');
const servedByOther = new Counter('served_by_other');

// Where the read came from (X-Cache header, Lab 4): HIT / MISS / BYPASS; "none" = original image without the cache.
const cacheHit = new Counter('cache_hit');
const cacheMiss = new Counter('cache_miss');
const cacheBypass = new Counter('cache_bypass');
const cacheNone = new Counter('cache_none');

export function inHold() {
  return Date.now() >= exec.scenario.startTime + RAMP_S * 1000;
}

function trackInstance(res) {
  const instance = res.headers['X-Instance-Id']; // k6 canonicalises header names
  if (instance === 'graph-1') servedByGraph1.add(1);
  else if (instance === 'graph-2') servedByGraph2.add(1);
  else if (instance === 'graph-3') servedByGraph3.add(1);
  else servedByOther.add(1);
}

function trackCache(res) {
  const cache = res.headers['X-Cache'];
  if (cache === 'HIT') cacheHit.add(1);
  else if (cache === 'MISS') cacheMiss.add(1);
  else if (cache === 'BYPASS') cacheBypass.add(1);
  else cacheNone.add(1);
}

function defaultRecorder(res, op) {
  if (!inHold()) return;
  const d = res.timings.duration;
  mReqs.add(1);
  mDur.add(d);
  if (res.status === 200) mDurOk.add(d); else mFailed.add(1);
  (op === 'read' ? durationRead : durationWrite).add(d);
  trackInstance(res);
  if (op === 'read') trackCache(res);
}

// staged-demo.js replaces the recorder with one that fills per-stage metrics.
let recorder = defaultRecorder;
export function setRecorder(fn) { recorder = fn; }

export function readGraph() {
  const res = http.get(`${BASE_URL}/api/v1/graph?organizationId=${ORG_ID}`, {
    headers: { 'X-User-Id': USER_ID },
    tags: { name: 'GET /api/v1/graph' },
    timeout: '60s',
  });
  check(res, { 'read: status is 200': (r) => r.status === 200 });
  recorder(res, 'read');
  return res;
}

export function createEntity() {
  const res = http.post(`${BASE_URL}/api/v1/workspaces/${WORKSPACE_ID}/entity-graph/create`, CREATE_BODY, {
    headers: { 'X-User-Id': USER_ID, 'Content-Type': 'application/json' },
    tags: { name: 'POST entity-graph/create' },
    timeout: '60s',
  });
  check(res, { 'write: status is 200': (r) => r.status === 200 });
  recorder(res, 'write');
  return res;
}

export function think(seconds) {
  sleep(seconds === undefined ? THINK_S : seconds);
}

// options.scenarios for one rung of the ladder: ramp 0 -> vus over RAMP_S (not measured), then hold for `hold`.
export function ladderScenario(vus, hold) {
  return {
    measure: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: `${RAMP_S}s`, target: vus },
        { duration: hold, target: vus },
      ],
      gracefulRampDown: '0s',
      gracefulStop: '30s',
    },
  };
}
