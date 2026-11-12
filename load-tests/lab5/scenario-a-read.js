// Lab 5 - Scenario A: READ-INTENSIVE.
//
// Profile : closed model. VUs ramp 0 -> VUS over RAMP_S (15 s, not measured), then VUS stay for DURATION (measured,
//           see lib/common.js). Each VU repeats "GET /api/v1/graph?organizationId=1" and waits THINK_MS (0.5 s).
// Resource: Redis (Cache-Aside, Lab 4), Graph CPU for JSON, nginx; on a MISS also PostgreSQL (7+ queries) and ML RPC.
// Note    : every VU asks for the SAME key (one user, one organization), so with the cache on this is the BEST case.
// Stats only: there are NO thresholds, the run is never "failed" by k6.
//
// One level of the ladder (10 / 50 / 100 / 200 VUs) is one run of this file; an extra short run of the same file with
// VUS=5 DURATION=15s is made first and discarded (scripts/run-k6.ps1 does both).
//
// Run (from the repo root):
//   k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" -e VUS=50 -e DURATION=60s `
//       --summary-export=summary.json load-tests/lab5/scenario-a-read.js

import { readGraph, think, ladderScenario } from './lib/common.js';

const VUS = parseInt(__ENV.VUS || '50', 10);
const DURATION = __ENV.DURATION || '60s';

export const options = {
  scenarios: ladderScenario(VUS, DURATION),
  // Intentionally no `thresholds`: statistics only.
};

export default function () {
  readGraph();
  think();
}

