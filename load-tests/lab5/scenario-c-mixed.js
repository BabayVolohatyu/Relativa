// Lab 5 - Scenario C: COMPLEX WORKFLOW (read -> compute -> write the final state).
//
// Profile : closed model. VUs ramp 0 -> VUS over RAMP_S (15 s, not measured), then VUS stay for DURATION (measured).
//           One iteration is an end-to-end business flow:
//             1. GET  /api/v1/graph?organizationId=1               (read; goes through the cache, on a MISS also ML scoring)
//             2. think 0.3 s                                       ("the user looks at the graph")
//             3. POST /api/v1/workspaces/1/entity-graph/create     (write; Graph -> RabbitMQ -> Core -> PostgreSQL)
//                                                                   and Graph then DELETES the cache keys of the organization
//             4. think 0.3 s
//           Because every write invalidates the organization's cache (Lab 4), the next reads of ALL users are MISSes:
//           this scenario shows the cache under write pressure, not in its best case.
// Resource: everything at once: Redis, PostgreSQL reads and writes, ML RPC, RabbitMQ, Core.
// Needs   : the Core container (see scenario-b-write.js). Cleanup is the same.
// Stats only: there are NO thresholds. duration_read / duration_write trends and cache_* counters split the two paths.
//
// Run (from the repo root):
//   k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" -e VUS=50 -e DURATION=60s `
//       --summary-export=summary.json load-tests/lab5/scenario-c-mixed.js

import { readGraph, createEntity, think, ladderScenario } from './lib/common.js';

const VUS = parseInt(__ENV.VUS || '50', 10);
const DURATION = __ENV.DURATION || '60s';

export const options = {
  scenarios: ladderScenario(VUS, DURATION),
};

export default function () {
  readGraph();
  think(0.3);
  createEntity();
  think(0.3);
}

