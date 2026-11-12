// Lab 3 - k6 load test, ASYMMETRIC LOAD: one of three Graph instances is slow.
//
// Target : nginx load balancer (port 8090) in front of graph-1, graph-2, graph-3.
//          graph-2 runs with ARTIFICIAL_DELAY_MS=500 (docker-compose.lab3-slow.yml): every request it handles
//          waits 500 ms first. graph-1 and graph-3 are normal.
// Purpose: run the SAME scenario twice, once with the Round Robin config and once with the Least Connections
//          config (switched live, see scripts/asymmetric-run.ps1), and compare the system p99 latency and the
//          traffic share of the slow node. Stats only, NO thresholds.
//
// The scenario is the same as post-lab/ (30 -> 50 VUs, 2 min, think time 0.5 s).
//
// Run (from repo root), after switching nginx to the wanted algorithm:
//   k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" `
//       --summary-export=<file>.json high-load-systems/evidence/lab3/k6/asymmetric/graph-load-test.js
//
// Env overrides: BASE_URL, USER_ID, ORG_ID

import http from 'k6/http';
import { check, sleep } from 'k6';
import { Counter, Trend } from 'k6/metrics';

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8090';
const USER_ID = __ENV.USER_ID || '1';
const ORG_ID = __ENV.ORG_ID || '1';

// Which instance answered (X-Instance-ID header).
const servedByGraph1 = new Counter('served_by_graph_1');
const servedByGraph2 = new Counter('served_by_graph_2'); // the slow one
const servedByGraph3 = new Counter('served_by_graph_3');
const servedByNone = new Counter('served_by_none');
const servedByOther = new Counter('served_by_other');

// Latency split by the instance that served the request (shows the slow node's own latency).
const durGraph1 = new Trend('duration_graph_1', true);
const durGraph2 = new Trend('duration_graph_2', true);
const durGraph3 = new Trend('duration_graph_3', true);

export const options = {
  scenarios: {
    graph_load: {
      executor: 'ramping-vus',
      startVUs: 30,
      stages: [
        { duration: '30s', target: 50 },
        { duration: '60s', target: 50 },
        { duration: '30s', target: 0 },
      ],
      gracefulRampDown: '10s',
    },
  },
  // Intentionally no `thresholds`: statistics only.
};

export default function () {
  const res = http.get(`${BASE_URL}/api/v1/graph?organizationId=${ORG_ID}`, {
    headers: { 'X-User-Id': USER_ID },
    tags: { name: 'GET /api/v1/graph' },
    timeout: '60s',
  });

  check(res, { 'status is 200': (r) => r.status === 200 });

  const instance = res.headers['X-Instance-Id']; // k6 canonicalises header names
  if (!instance) servedByNone.add(1);
  else if (instance === 'graph-1') { servedByGraph1.add(1); durGraph1.add(res.timings.duration); }
  else if (instance === 'graph-2') { servedByGraph2.add(1); durGraph2.add(res.timings.duration); }
  else if (instance === 'graph-3') { servedByGraph3.add(1); durGraph3.add(res.timings.duration); }
  else servedByOther.add(1);

  sleep(0.5);
}
