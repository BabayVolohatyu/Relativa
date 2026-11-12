// Lab 5 - Scenario B: WRITE-INTENSIVE.
//
// Profile : closed model. VUs ramp 0 -> VUS over RAMP_S (15 s, not measured), then VUS stay for DURATION (measured).
//           Each VU repeats "POST /api/v1/workspaces/1/entity-graph/create" (a new "client" entity) and waits THINK_MS (0.5 s).
// Path    : nginx -> Graph -> RabbitMQ RPC (a new connection + channel + reply queue per request) -> Core ->
//           PostgreSQL transaction (entity + property values + workspace link + audit log) -> reply -> Graph.
// Resource: I/O and transactions in PostgreSQL, RabbitMQ, the single Core consumer, JSON serialisation.
// Needs   : the Core container (`docker compose ... up -d --no-build core`). Without it every call hangs 30 s -> 504.
// Cleanup : the created entities carry first_name "Lab5WriteTest"; scripts/run-k6.ps1 counts and archives them.
// Stats only: there are NO thresholds.
//
// Run (from the repo root):
//   k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" -e VUS=50 -e DURATION=60s `
//       --summary-export=summary.json load-tests/lab5/scenario-b-write.js

import { createEntity, think, ladderScenario } from './lib/common.js';

const VUS = parseInt(__ENV.VUS || '50', 10);
const DURATION = __ENV.DURATION || '60s';

export const options = {
  scenarios: ladderScenario(VUS, DURATION),
};

export default function () {
  createEntity();
  think();
}

