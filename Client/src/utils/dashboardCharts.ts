export interface TrendMonth {
  label: string;
  newDeals: number;
  closedWon: number;
  closedLost: number;
  wonRevenue: number;
}

type Labeler = (key: string) => string;

export function buildTrendsChartData(trends: { months: TrendMonth[] } | null | undefined, label: Labeler) {
  if (!trends) return null;
  return {
    labels: trends.months.map((m) => m.label),
    datasets: [
      {
        label: label('home.dsPipelineDeals'),
        data: trends.months.map((m) => m.newDeals),
        borderColor: '#3b82f6',
        backgroundColor: 'rgba(59,130,246,0.08)',
        fill: true,
        tension: 0.3,
        yAxisID: 'y',
      },
      {
        label: label('home.dsWon'),
        data: trends.months.map((m) => m.closedWon),
        borderColor: '#10b981',
        backgroundColor: 'transparent',
        fill: false,
        tension: 0.3,
        yAxisID: 'y',
      },
      {
        label: label('home.dsLost'),
        data: trends.months.map((m) => m.closedLost),
        borderColor: '#ef4444',
        backgroundColor: 'transparent',
        fill: false,
        tension: 0.3,
        yAxisID: 'y',
      },
      {
        label: label('home.dsWonRevenue'),
        data: trends.months.map((m) => m.wonRevenue),
        borderColor: '#8b5cf6',
        backgroundColor: 'transparent',
        fill: false,
        tension: 0.3,
        yAxisID: 'y1',
        borderDash: [4, 4],
      },
    ],
  };
}

export function buildTrendsChartOptions(label: Labeler) {
  return {
    responsive: true,
    maintainAspectRatio: false,
    interaction: { mode: 'index' as const, intersect: false },
    plugins: {
      legend: { position: 'top' as const, labels: { color: '#334155', boxWidth: 12 } },
    },
    scales: {
      y: {
        type: 'linear' as const,
        position: 'left' as const,
        grid: { color: '#f1f5f9' },
        ticks: { color: '#64748b', stepSize: 1 },
        title: { display: true, text: label('home.axisDeals'), color: '#94a3b8' },
      },
      y1: {
        type: 'linear' as const,
        position: 'right' as const,
        grid: { drawOnChartArea: false },
        ticks: {
          color: '#8b5cf6',
          callback: (v: number) => `€${(v / 1000).toFixed(0)}k`,
        },
        title: { display: true, text: label('home.axisRevenue'), color: '#8b5cf6' },
      },
      x: { grid: { display: false }, ticks: { color: '#64748b' } },
    },
  };
}

export function formatCurrency(v: number) {
  return new Intl.NumberFormat('de-DE', {
    style: 'currency',
    currency: 'EUR',
    maximumFractionDigits: 0,
  }).format(v);
}

export function priorityClass(priority?: string) {
  switch (priority?.toLowerCase()) {
    case 'high':
      return 'danger';
    case 'medium':
      return 'warn';
    default:
      return 'secondary';
  }
}

export function riskClass(bucket: string) {
  switch (bucket) {
    case 'high':
      return 'danger';
    case 'medium':
      return 'warn';
    case 'low':
      return 'success';
    default:
      return 'secondary';
  }
}

export function scoreBar(score?: number | null) {
  return score != null ? Math.round(score * 100) : null;
}
