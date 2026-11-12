// Lab 3 - k6 scale-out (saturation) test: 1 vs 2 vs 3 Graph instances behind the same nginx.
//
// Why a different scenario than pre-lab/post-lab: that one (50 VUs, 0.5 s think time) is latency-bound and never
// saturates one instance (see Lab 2 COMPARISON.md), so it cannot show scale-out. Here every VU fires the next
// request immediately (no think time) with many VUs, so the system is driven to its capacity and the throughput
// that comes out is a capacity figure. Each Graph instance is CPU-limited to 1 core
// (docker-compose.lab3-cpulimit.yml) so that "one more instance" really means "one more core of compute".
//
// Stats only, no thresholds. Run through scale-out-run.ps1, which sets up nginx for N instances.
//
//   k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" `
//       --summary-export=<file>.json high-load-systems/evidence/lab3/k6/scale-out/graph-scale-test.js
//
// Env overrides: BASE_URL, USER_ID, ORG_ID, VUS (default 120), HOLD (default 50s)

import http from 'k6/http';
import { check } from 'k6';
import { Counter } from 'k6/metrics';

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8090';
const USER_ID = __ENV.USER_ID || '1';
const ORG_ID = __ENV.ORG_ID || '1';
const VUS = parseInt(__ENV.VUS || '120');
const HOLD = __ENV.HOLD || '50s';

const servedByGraph1 = new Counter('served_by_graph_1');
const servedByGraph2 = new Counter('served_by_graph_2');
const servedByGraph3 = new Counter('served_by_graph_3');
const servedByNone = new Counter('served_by_none');
const servedByOther = new Counter('served_by_other');

export const options = {
  scenarios: {
    saturation: {
      executor: 'ramping-vus',
      startVUs: 10,
      stages: [
        { duration: '10s', target: VUS }, // ramp up
        { duration: HOLD, target: VUS },  // hold: this is the measured plateau
      ],
      gracefulStop: '30s',
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

  const instance = res.headers['X-Instance-Id'];
  if (!instance) servedByNone.add(1);
  else if (instance === 'graph-1') servedByGraph1.add(1);
  else if (instance === 'graph-2') servedByGraph2.add(1);
  else if (instance === 'graph-3') servedByGraph3.add(1);
  else servedByOther.add(1);
  // no sleep: closed loop at full speed
}
