// Lab 2 - k6 load test, POST-LAB.
//
// Target : nginx round-robin load balancer (port 8090) in front of TWO Graph instances (graph-1, graph-2).
// State  : the REFACTORED code (Redis IDistributedCache, Redis SignalR backplane, X-Instance-ID header).
// Purpose: record stats only. There are NO thresholds - the run is never "failed" by k6.
//
// Scenario is the same in pre-lab/ and post-lab/; only BASE_URL differs.
//
// Run (from repo root):
//   k6 run --summary-export=high-load-systems/evidence/lab2/k6/post-lab/summary.json \
//          high-load-systems/evidence/lab2/k6/post-lab/graph-load-test.js
//
// Env overrides: BASE_URL, USER_ID, ORG_ID

import http from 'k6/http';
import { check, sleep } from 'k6';
import { Counter } from 'k6/metrics';

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8090';
const USER_ID = __ENV.USER_ID || '1'; // seeded org_owner of organization 1
const ORG_ID = __ENV.ORG_ID || '1';   // seeded organization with the biggest workspace (157 entities)

// Which instance answered (X-Instance-ID). Both graph-1 and graph-2 should receive about half of the traffic.
const servedByGraph1 = new Counter('served_by_graph_1');
const servedByGraph2 = new Counter('served_by_graph_2');
const servedByNone = new Counter('served_by_none');
const servedByOther = new Counter('served_by_other');

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
  else servedByOther.add(1);

  sleep(0.5);
}
