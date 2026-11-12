// Lab 4 - k6 load test (used UNCHANGED for pre-lab and post-lab; only the Graph image behind BASE_URL differs).
//
// Target : nginx load balancer (port 8090, Round Robin) in front of THREE Graph instances (Lab 3 topology).
// Pre-lab : the original Graph image (no cache)              -> every response has no X-Cache header ("none").
// Post-lab: the Lab 4 Graph image (Cache-Aside through Redis) -> X-Cache is HIT / MISS / BYPASS.
// Purpose: record stats only. There are NO thresholds - the run is never "failed" by k6.
//
// The scenario is the same as in Lab 2 / Lab 3: 30 -> 50 VUs, one identical request (same user, same organization),
// 0.5 s think time. With a cache that means one cache key, so it measures the BEST CASE of the cache (hot key).
//
// Run (from repo root):
//   k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" `
//       --summary-export=high-load-systems/evidence/lab4/k6/post-lab/summary.run1.json `
//       high-load-systems/evidence/lab4/k6/post-lab/graph-load-test.js
//
// Env overrides: BASE_URL, USER_ID, ORG_ID

import http from 'k6/http';
import { check, sleep } from 'k6';
import { Counter, Trend } from 'k6/metrics';

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8090';
const USER_ID = __ENV.USER_ID || '1'; // seeded org_owner of organization 1
const ORG_ID = __ENV.ORG_ID || '1';   // seeded organization with the biggest workspace (157 entities)

// Which instance answered (X-Instance-ID header). Round Robin: each should get about one third.
const servedByGraph1 = new Counter('served_by_graph_1');
const servedByGraph2 = new Counter('served_by_graph_2');
const servedByGraph3 = new Counter('served_by_graph_3');
const servedByNone = new Counter('served_by_none');
const servedByOther = new Counter('served_by_other');

// Where the data came from (X-Cache header, Lab 4).
const cacheHit = new Counter('cache_hit');
const cacheMiss = new Counter('cache_miss');
const cacheBypass = new Counter('cache_bypass');
const cacheNone = new Counter('cache_none');
// Latency split by cache outcome, so the cold (MISS) and hot (HIT) paths can be read separately.
const durationHit = new Trend('duration_cache_hit', true);
const durationMiss = new Trend('duration_cache_miss', true);

export const options = {
  scenarios: {
    graph_load: {
      executor: 'ramping-vus',
      startVUs: 30,
      stages: [
        { duration: '30s', target: 50 }, // 30 -> 50 VUs
        { duration: '60s', target: 50 }, // hold
        { duration: '30s', target: 0 },  // ramp down
      ],
      gracefulRampDown: '10s',
    },
  },
  // Intentionally no `thresholds`: statistics only.
};

export default function () {
  // The Graph service trusts X-User-Id (set by the Gateway after JWT validation in the real stack).
  const res = http.get(`${BASE_URL}/api/v1/graph?organizationId=${ORG_ID}`, {
    headers: { 'X-User-Id': USER_ID },
    tags: { name: 'GET /api/v1/graph' },
    timeout: '60s',
  });

  check(res, { 'status is 200': (r) => r.status === 200 });

  const instance = res.headers['X-Instance-Id']; // k6 canonicalises header names
  if (!instance) servedByNone.add(1);
  else if (instance === 'graph-1') servedByGraph1.add(1);
  else if (instance === 'graph-2') servedByGraph2.add(1);
  else if (instance === 'graph-3') servedByGraph3.add(1);
  else servedByOther.add(1);

  const cache = res.headers['X-Cache'];
  if (cache === 'HIT') { cacheHit.add(1); durationHit.add(res.timings.duration); }
  else if (cache === 'MISS') { cacheMiss.add(1); durationMiss.add(res.timings.duration); }
  else if (cache === 'BYPASS') cacheBypass.add(1);
  else cacheNone.add(1);

  sleep(0.5);
}
