import http from 'k6/http';
import { check } from 'k6';

const gateway = __ENV.GATEWAY || 'http://localhost:8080';
const email = __ENV.ADMIN_EMAIL || 'admin@relativa.com';
const password = __ENV.ADMIN_PASSWORD || 'Demo1234!';
const profile = (__ENV.PROFILE || 'normal').toLowerCase();

// Interactive graph read. Calibration on 2026-10-18, normal profile, 5 VUs:
// measured p95 = 899 ms. SLO p95 = max(500, 899 * 3) = 2700 ms.
// Error rate stays under 1%. An 8 s ML stall would breach this budget.
const p95 = Number(__ENV.P95_MS || 2700);
const errorRate = __ENV.ERROR_RATE || '0.01';

const stages = {
  normal: [
    { duration: '10s', target: 5 },
    { duration: '20s', target: 5 },
    { duration: '5s', target: 0 },
  ],
  elevated: [
    { duration: '10s', target: 40 },
    { duration: '20s', target: 40 },
    { duration: '5s', target: 0 },
  ],
};

const durationMetric = 'http_req_duration{name:graph_read}';
const failedMetric = 'http_req_failed{name:graph_read}';
const reqsMetric = 'http_reqs{name:graph_read}';

export const options = {
  summaryTrendStats: ['avg', 'min', 'med', 'max', 'p(90)', 'p(95)', 'p(99)'],
  scenarios: {
    graph_read: {
      executor: 'ramping-vus',
      stages: stages[profile] || stages.normal,
    },
  },
  thresholds: {
    [durationMetric]: [`p(95)<${p95}`],
    [failedMetric]: [`rate<${errorRate}`],
    [reqsMetric]: ['count>0'],
  },
};

export function setup() {
  const login = http.post(
    `${gateway}/auth/api/v1/auth/login`,
    JSON.stringify({ email, password }),
    { headers: { 'Content-Type': 'application/json' } },
  );
  if (login.status !== 200) {
    throw new Error(`login failed: ${login.status} ${login.body}`);
  }
  const token = login.json('accessToken');
  if (!token) {
    throw new Error(`login returned no accessToken: ${login.body}`);
  }

  const orgs = http.get(`${gateway}/core/api/v1/organizations/`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (orgs.status !== 200) {
    throw new Error(`organizations failed: ${orgs.status} ${orgs.body}`);
  }
  const list = orgs.json();
  const orgId = Array.isArray(list) ? list[0] && list[0].id : list.id;
  if (!orgId) {
    throw new Error(`no organization id in ${orgs.body}`);
  }
  return { token, orgId };
}

export default function (data) {
  const res = http.get(
    `${gateway}/graph/api/v1/graph?organizationId=${data.orgId}`,
    {
      headers: { Authorization: `Bearer ${data.token}` },
      tags: { name: 'graph_read' },
    },
  );
  check(res, { 'status is 200': (r) => r.status === 200 });
}

function metricValues(data, name) {
  const metric = data.metrics[name];
  return metric ? metric.values : null;
}

function thresholdsPassed(data, name) {
  const metric = data.metrics[name];
  if (!metric || !metric.thresholds) return true;
  return Object.values(metric.thresholds).every((t) => t.ok);
}

export function handleSummary(data) {
  const dur = metricValues(data, durationMetric) || {};
  const failed = metricValues(data, failedMetric) || {};
  const reqs = metricValues(data, reqsMetric) || {};
  const pass =
    thresholdsPassed(data, durationMetric) && thresholdsPassed(data, failedMetric);
  const lines = [
    '=== LAB2 GRAPH READ SUMMARY ===',
    `profile=${profile}`,
    `p95_threshold_ms=${p95}`,
    `error_rate_threshold=${errorRate}`,
    `p90_ms=${dur['p(90)']}`,
    `p95_ms=${dur['p(95)']}`,
    `p99_ms=${dur['p(99)']}`,
    `avg_ms=${dur.avg}`,
    `rps=${reqs.rate}`,
    `http_reqs=${reqs.count}`,
    `error_rate=${failed.rate}`,
    `result=${pass ? 'PASS' : 'FAIL'}`,
    '=== END SUMMARY ===',
  ];
  return { stdout: `${lines.join('\n')}\n` };
}
