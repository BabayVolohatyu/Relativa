// Lab 5 - STAGED RAMP-UP in ONE run (the live demo for the defence): 10 -> 25 -> 50 -> 100 -> 200 VUs.
//
// One ramping-vus scenario. Every stage is STAGE seconds (default 40): the first RAMP seconds of the stage add VUs
// linearly (from the previous level), the rest is the HOLD of that level. Only requests that finish during a HOLD are
// recorded, into per-stage metrics:
//   stage_dur_<N> (Trend, latency)   stage_req_<N> (Counter, requests)   stage_err_<N> (Counter, status != 200)
// scripts/staged-table.ps1 turns them into the table of lab section 2.4 (throughput = requests / HOLD seconds).
// A first WARMUP stage (5 VUs, default 15 s) initialises pools / JIT and is not recorded. No thresholds.
//
// SCENARIO=A (read) | B (write) | C (read, think 0.3 s, write, think 0.3 s), default A.
//
// Run (from the repo root):
//   k6 run -q --summary-trend-stats="avg,min,med,max,p(90),p(95),p(99)" -e SCENARIO=A `
//       --summary-export=summary.json load-tests/lab5/staged-demo.js

import exec from 'k6/execution';
import { Counter, Trend } from 'k6/metrics';
import { readGraph, createEntity, think, setRecorder } from './lib/common.js';

const SCENARIO = (__ENV.SCENARIO || 'A').toUpperCase();
const STAGE_S = parseInt(__ENV.STAGE || '40', 10);
const RAMP_S = parseInt(__ENV.STAGE_RAMP || '10', 10);
const WARMUP_S = parseInt(__ENV.WARMUP || '15', 10);
const LEVELS = [10, 25, 50, 100, 200];

const dur = {};
const req = {};
const err = {};
for (const n of LEVELS) {
  dur[n] = new Trend(`stage_dur_${n}`, true);
  req[n] = new Counter(`stage_req_${n}`);
  err[n] = new Counter(`stage_err_${n}`);
}

const stages = [{ duration: `${WARMUP_S}s`, target: 5 }];
for (const n of LEVELS) {
  stages.push({ duration: `${RAMP_S}s`, target: n });
  stages.push({ duration: `${STAGE_S - RAMP_S}s`, target: n });
}

export const options = {
  scenarios: {
    ladder: { executor: 'ramping-vus', startVUs: 5, stages, gracefulRampDown: '0s', gracefulStop: '30s' },
  },
};

// Which level is in its HOLD right now (null during warm-up and during ramps).
function holdLevel() {
  const t = (Date.now() - exec.scenario.startTime) / 1000 - WARMUP_S;
  if (t < 0) return null;
  const i = Math.floor(t / STAGE_S);
  if (i >= LEVELS.length) return null;
  return (t - i * STAGE_S) >= RAMP_S ? LEVELS[i] : null;
}

setRecorder((res) => {
  const n = holdLevel();
  if (n === null) return;
  dur[n].add(res.timings.duration);
  req[n].add(1);
  if (res.status !== 200) err[n].add(1);
});

export default function () {
  if (SCENARIO === 'A') {
    readGraph();
    think();
  } else if (SCENARIO === 'B') {
    createEntity();
    think();
  } else {
    readGraph();
    think(0.3);
    createEntity();
    think(0.3);
  }
}
