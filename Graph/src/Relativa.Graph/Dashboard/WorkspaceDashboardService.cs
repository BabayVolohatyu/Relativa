using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Distributed;
using Relativa.Graph.Dashboard.Dto;
using Relativa.Graph.Data;
using Relativa.Graph.ML;

namespace Relativa.Graph.Dashboard;

public sealed class WorkspaceDashboardService(
    GraphQueryDbContext db,
    IMlScoringClient mlClient,
    IMlRecalculationClient mlRecalc,
    IDistributedCache cache)
    : IWorkspaceDashboardService
{
    private const string EnqueueCooldownPrefix = "ml-enqueue-cooldown:";
    private static readonly TimeSpan EnqueueCooldown = TimeSpan.FromMinutes(5);
    private const string ViewAnalytics   = "view_analytics";
    private const string ViewBasicStats  = "view_basic_stats";
    private const string ViewTeamAnalytics = "view_team_analytics";

    private static readonly string[] PipelineStageOrder =
        ["Prospecting", "Qualification", "Proposal", "Negotiation"];

    // ──────────────────────────────────────────────────────────────────────────
    // Permission helpers
    // ──────────────────────────────────────────────────────────────────────────

    private async Task<bool> IsOrgOwnerAsync(int userId, int workspaceId, CancellationToken ct)
    {
        var orgId = await db.Workspaces
            .Where(w => w.Id == workspaceId && !w.IsArchived)
            .Select(w => (int?)w.OrganizationId)
            .FirstOrDefaultAsync(ct);

        if (orgId is null)
            return false;

        return await db.UserRoleOrganizations
            .Where(uro => uro.UserId == userId
                          && uro.OrganizationId == orgId
                          && !uro.IsArchived)
            .AnyAsync(uro => uro.Role.Name == "org_owner", ct);
    }

    private async Task<HashSet<string>> GetWorkspacePermissionsAsync(
        int userId, int workspaceId, CancellationToken ct)
    {
        if (await IsOrgOwnerAsync(userId, workspaceId, ct))
            return [ViewAnalytics, ViewBasicStats, ViewTeamAnalytics];

        return await db.UserRoleWorkspaces
            .Where(urw => urw.UserId == userId
                          && urw.WorkspaceId == workspaceId
                          && !urw.IsArchived)
            .SelectMany(urw => urw.Role.RolePermissions.Select(rp => rp.Permission.Name))
            .ToHashSetAsync(ct);
    }

    private async Task RequirePermissionAsync(
        int userId, int workspaceId, string permission, CancellationToken ct)
    {
        var perms = await GetWorkspacePermissionsAsync(userId, workspaceId, ct);
        if (!perms.Contains(permission))
            throw new ForbiddenAccessException($"Requires {permission} permission.");
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Shared EAV helpers (workspace-scoped)
    // ──────────────────────────────────────────────────────────────────────────

    private async Task<List<int>> GetEntityIdsAsync(
        int workspaceId, string typeName, CancellationToken ct)
    {
        return await db.EntityWorkspaces
            .Where(ew => ew.WorkspaceId == workspaceId
                         && !ew.Entity.IsArchived
                         && ew.Entity.EntityType.Name == typeName)
            .Select(ew => ew.EntityId)
            .Distinct()
            .ToListAsync(ct);
    }

    private sealed record PropertyRow(
        int EntityId,
        string Name,
        string? ValueString,
        int? ValueInt,
        decimal? ValueDecimal,
        bool? ValueBool,
        DateOnly? ValueDate);

    private static string? FormatValue(PropertyRow row) =>
        row.ValueString
        ?? row.ValueInt?.ToString()
        ?? row.ValueDecimal?.ToString()
        ?? (row.ValueBool.HasValue ? row.ValueBool.Value.ToString() : null)
        ?? row.ValueDate?.ToString("yyyy-MM-dd");

    private async Task<Dictionary<int, Dictionary<string, string?>>> GetPropertyValuesAsync(
        List<int> entityIds, IEnumerable<string> propertyNames, CancellationToken ct)
    {
        if (entityIds.Count == 0)
            return new Dictionary<int, Dictionary<string, string?>>();

        var propSet = propertyNames.ToHashSet(StringComparer.OrdinalIgnoreCase);
        var rows = await db.EntityPropertyValues
            .Where(epv => entityIds.Contains(epv.EntityId)
                          && propSet.Contains(epv.Property.Name))
            .Select(epv => new PropertyRow(
                epv.EntityId,
                epv.Property.Name,
                epv.ValueString,
                epv.ValueInt,
                epv.ValueDecimal,
                epv.ValueBool,
                epv.ValueDate))
            .ToListAsync(ct);

        var result = new Dictionary<int, Dictionary<string, string?>>();
        foreach (var row in rows)
        {
            if (!result.TryGetValue(row.EntityId, out var props))
            {
                props = new Dictionary<string, string?>(StringComparer.OrdinalIgnoreCase);
                result[row.EntityId] = props;
            }
            props[row.Name] = FormatValue(row);
        }
        return result;
    }

    private static string? Prop(
        IReadOnlyDictionary<int, Dictionary<string, string?>> props, int id, string name) =>
        props.GetValueOrDefault(id)?.GetValueOrDefault(name);

    private static decimal Money(string? raw) => decimal.TryParse(raw, out var value) ? value : 0m;

    private static decimal DealValue(
        IReadOnlyDictionary<int, Dictionary<string, string?>> props, int id) =>
        Money(Prop(props, id, "deal_value"));

    /// <summary>Deal status exactly as stored (case preserved, missing = empty string).</summary>
    private static string RawStatus(
        IReadOnlyDictionary<int, Dictionary<string, string?>> props, int id) =>
        Prop(props, id, "status") ?? "";

    // ──────────────────────────────────────────────────────────────────────────
    // Summary
    // ──────────────────────────────────────────────────────────────────────────

    public async Task<WorkspaceSummaryDto> GetSummaryAsync(
        int userId, int workspaceId, CancellationToken ct)
    {
        var perms = await GetWorkspacePermissionsAsync(userId, workspaceId, ct);
        bool hasFull  = perms.Contains(ViewAnalytics);
        bool hasBasic = perms.Contains(ViewBasicStats);

        if (!hasFull && !hasBasic)
            throw new ForbiddenAccessException(
                "Requires view_analytics or view_basic_stats permission.");

        var workspace = await db.Workspaces
            .Where(w => w.Id == workspaceId && !w.IsArchived)
            .Select(w => new { w.Id, w.Name })
            .FirstOrDefaultAsync(ct)
            ?? throw new WorkspaceNotFoundException(workspaceId);

        var dealIds   = await GetEntityIdsAsync(workspaceId, "deal",   ct);
        var clientIds = await GetEntityIdsAsync(workspaceId, "client", ct);

        var memberCount = await db.UserRoleWorkspaces
            .Where(urw => urw.WorkspaceId == workspaceId && !urw.IsArchived)
            .Select(urw => urw.UserId)
            .Distinct()
            .CountAsync(ct);

        if (!hasFull)
        {
            var basicDealProps   = await GetPropertyValuesAsync(dealIds,   ["status"],        ct);
            var basicClientProps = await GetPropertyValuesAsync(clientIds, ["client_status"], ct);
            var outcomes = CountDealStatuses(dealIds, basicDealProps);

            return new WorkspaceSummaryDto(
                workspace.Id, workspace.Name,
                dealIds.Count, outcomes.Open, outcomes.Won, outcomes.Lost,
                null, null, null,
                clientIds.Count, CountActiveClients(clientIds, basicClientProps),
                null, null, memberCount, "basic");
        }

        var today          = DateOnly.FromDateTime(DateTime.UtcNow);
        var thisMonthStart = new DateOnly(today.Year, today.Month, 1);
        var nextMonthStart = thisMonthStart.AddMonths(1);

        var dealProps   = await GetPropertyValuesAsync(dealIds,   ["status", "deal_value", "expected_close"], ct);
        var clientProps = await GetPropertyValuesAsync(clientIds, ["client_status"],                          ct);
        var taskIds     = await GetEntityIdsAsync(workspaceId, "task", ct);
        var taskProps   = await GetPropertyValuesAsync(taskIds, ["task_status", "due_date"], ct);

        var outcomesFull   = CountDealStatuses(dealIds, dealProps);
        var totalDealValue = SumDealValues(dealIds, dealProps);
        var closedOrLost   = outcomesFull.Won + outcomesFull.Lost;
        var winRate        = closedOrLost > 0 ? Math.Round((double)outcomesFull.Won / closedOrLost, 4) : 0.0;
        var avgDealSize    = dealIds.Count > 0 ? Math.Round(totalDealValue / dealIds.Count, 2) : 0m;

        return new WorkspaceSummaryDto(
            workspace.Id, workspace.Name,
            dealIds.Count, outcomesFull.Open, outcomesFull.Won, outcomesFull.Lost,
            totalDealValue, winRate, avgDealSize,
            clientIds.Count, CountActiveClients(clientIds, clientProps),
            CountClosingThisMonth(dealIds, dealProps, thisMonthStart, nextMonthStart),
            CountOverdueTasks(taskIds, taskProps, today),
            memberCount, "full");
    }

    private readonly record struct DealStatusCounts(int Won, int Lost, int Open);

    private static DealStatusCounts CountDealStatuses(
        IReadOnlyList<int> dealIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> props)
    {
        int won = 0, lost = 0, open = 0;
        foreach (var id in dealIds)
        {
            switch (DealStatus(props, id))
            {
                case "closed":  won++;  break;
                case "revoked": lost++; break;
                default:        open++; break;
            }
        }

        return new DealStatusCounts(won, lost, open);
    }

    /// <summary>Deal status lower-cased (missing = empty string).</summary>
    private static string DealStatus(
        IReadOnlyDictionary<int, Dictionary<string, string?>> props, int id) =>
        RawStatus(props, id).ToLowerInvariant();

    private static decimal SumDealValues(
        IReadOnlyList<int> dealIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> props)
    {
        decimal total = 0m;
        foreach (var id in dealIds)
            total += DealValue(props, id);

        return total;
    }

    private static int CountClosingThisMonth(
        IReadOnlyList<int> dealIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> props,
        DateOnly monthStart,
        DateOnly nextMonthStart)
    {
        int closing = 0;
        foreach (var id in dealIds)
        {
            var rawClose = Prop(props, id, "expected_close");
            if (rawClose is not null && DateOnly.TryParse(rawClose, out var closeDate)
                && closeDate >= monthStart && closeDate < nextMonthStart)
                closing++;
        }

        return closing;
    }

    private static int CountActiveClients(
        IReadOnlyList<int> clientIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> props) =>
        clientIds.Count(id => string.Equals(
            Prop(props, id, "client_status"),
            "active", StringComparison.OrdinalIgnoreCase));

    private static int CountOverdueTasks(
        IReadOnlyList<int> taskIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> props,
        DateOnly today)
    {
        int overdue = 0;
        foreach (var id in taskIds)
        {
            if (string.Equals(Prop(props, id, "task_status"), "done", StringComparison.OrdinalIgnoreCase))
                continue;
            var rawDue = Prop(props, id, "due_date");
            if (rawDue is not null && DateOnly.TryParse(rawDue, out var due) && due < today)
                overdue++;
        }

        return overdue;
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Pipeline
    // ──────────────────────────────────────────────────────────────────────────

    public async Task<PipelineDto> GetPipelineAsync(
        int userId, int workspaceId, CancellationToken ct)
    {
        await RequirePermissionAsync(userId, workspaceId, ViewAnalytics, ct);

        var dealIds   = await GetEntityIdsAsync(workspaceId, "deal", ct);
        var dealProps = await GetPropertyValuesAsync(dealIds, ["deal_stage", "status", "deal_value"], ct);

        var tally  = TallyPipeline(dealIds, dealProps);
        var stages = BuildPipelineStages(tally.StageGroups, dealIds.Count);

        var closedOrLost   = tally.Won + tally.Lost;
        var conversionRate = closedOrLost > 0 ? Math.Round((double)tally.Won / closedOrLost, 4) : 0.0;
        var closedDealIds  = dealIds.Where(id => RawStatus(dealProps, id) == "closed").ToList();
        var closedProps    = await GetPropertyValuesAsync(closedDealIds, ["expected_close"], ct);
        var avgDaysToClose = AverageDaysToClose(
            closedDealIds, closedProps, DateOnly.FromDateTime(DateTime.UtcNow));

        return new PipelineDto(stages, tally.StatusBreakdown, conversionRate, avgDaysToClose);
    }

    private sealed record PipelineTally(
        Dictionary<string, (int count, decimal value)> StageGroups,
        Dictionary<string, int> StatusBreakdown,
        int Won,
        int Lost);

    private static PipelineTally TallyPipeline(
        IReadOnlyList<int> dealIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> props)
    {
        var stageGroups = new Dictionary<string, (int count, decimal value)>(StringComparer.OrdinalIgnoreCase);
        foreach (var s in PipelineStageOrder) stageGroups[s] = (0, 0);

        var statusBreakdown = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase)
        { ["opened"] = 0, ["pending"] = 0, ["closed"] = 0, ["revoked"] = 0 };

        int wonDeals = 0, lostDeals = 0;

        foreach (var id in dealIds)
        {
            var stage  = Prop(props, id, "deal_stage") ?? "";
            var status = (Prop(props, id, "status") ?? "opened").ToLowerInvariant();
            var value  = DealValue(props, id);

            if (!string.IsNullOrEmpty(stage) && stageGroups.TryGetValue(stage, out var sg))
                stageGroups[stage] = (sg.count + 1, sg.value + value);

            CountStatus(statusBreakdown, status);

            if (status == "closed")  wonDeals++;
            if (status == "revoked") lostDeals++;
        }

        return new PipelineTally(stageGroups, statusBreakdown, wonDeals, lostDeals);
    }

    private static void CountStatus(Dictionary<string, int> breakdown, string status)
    {
        if (breakdown.ContainsKey(status)) breakdown[status]++;
        else breakdown["opened"]++;
    }

    private static List<PipelineStageDto> BuildPipelineStages(
        Dictionary<string, (int count, decimal value)> stageGroups, int totalCount) =>
        PipelineStageOrder.Select(s => ToStageDto(s, stageGroups[s], totalCount)).ToList();

    private static PipelineStageDto ToStageDto(string name, (int count, decimal value) group, int totalCount) =>
        new(name, group.count, group.value,
            totalCount > 0 ? Math.Round((double)group.count / totalCount, 4) : 0.0);

    private static double AverageDaysToClose(
        IReadOnlyList<int> closedDealIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> closedProps,
        DateOnly today)
    {
        double totalDaysToClose = 0;
        int closedCount = 0;

        foreach (var id in closedDealIds)
        {
            var raw = Prop(closedProps, id, "expected_close");
            if (raw is null || !DateOnly.TryParse(raw, out var closeDate)) continue;

            totalDaysToClose += Math.Abs(
                (today.ToDateTime(TimeOnly.MinValue) - closeDate.ToDateTime(TimeOnly.MinValue)).TotalDays);
            closedCount++;
        }

        return closedCount > 0 ? Math.Round(totalDaysToClose / closedCount, 1) : 0.0;
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Risk distribution
    // ──────────────────────────────────────────────────────────────────────────

    public async Task<RiskDistributionDto> GetRiskDistributionAsync(
        int userId, int workspaceId, CancellationToken ct)
    {
        await RequirePermissionAsync(userId, workspaceId, ViewAnalytics, ct);

        var dealIds   = await GetEntityIdsAsync(workspaceId, "deal", ct);
        var dealProps = await GetPropertyValuesAsync(dealIds, ["title", "deal_value", "status"], ct);

        var activeDealIds = dealIds
            .Where(id => IsActiveStatus(RawStatus(dealProps, id)))
            .ToList();

        var mlScores = await mlClient.ScoreBatchAsync(activeDealIds, ct);

        await EnqueueUnscoredDealsAsync(activeDealIds, mlScores, userId, workspaceId, ct);

        var dealClientRels = await db.EntityRelationships
            .Where(er => dealIds.Contains(er.SourceEntityId) && er.RelationshipType.Name == "deal_client")
            .Select(er => new { er.SourceEntityId, er.TargetEntityId })
            .ToListAsync(ct);

        var clientIds     = dealClientRels.Select(r => r.TargetEntityId).Distinct().ToList();
        var clientProps   = await GetPropertyValuesAsync(clientIds, ["company_name", "name", "first_name"], ct);
        var dealClientMap = dealClientRels.ToDictionary(r => r.SourceEntityId, r => r.TargetEntityId);

        var items = BuildRiskItems(activeDealIds, mlScores, dealProps, clientProps, dealClientMap);

        return new RiskDistributionDto(
            BuildRiskBuckets(items),
            items.OrderBy(i => i.Score).ToList());
    }

    private static bool IsActiveStatus(string status) => status is "opened" or "pending" or "";

    private static bool IsUnscored(IReadOnlyDictionary<int, MlScoreDto> mlScores, int id) =>
        !mlScores.TryGetValue(id, out var s) || (s.ClosureScore is null && s.UnavailableReason is null);

    private async Task EnqueueUnscoredDealsAsync(
        IReadOnlyList<int> activeDealIds,
        IReadOnlyDictionary<int, MlScoreDto> mlScores,
        int userId, int workspaceId, CancellationToken ct)
    {
        // Only enqueue deals that genuinely have no score — exclude deals ML explicitly
        // marked as unavailable (UnavailableReason != null) since re-enqueuing them
        // would cause an infinite recalculation loop.
        var unscoredIds = activeDealIds.Where(id => IsUnscored(mlScores, id)).ToList();

        // Rate-limit to prevent the completed→getRiskDistribution→re-enqueue loop:
        // only trigger a new ML run if we haven't triggered one in the last 5 minutes.
        // The cooldown key lives in the shared IDistributedCache (Redis), NOT in process memory,
        // so every Graph instance sees the same cooldown (stateless worker, Lab 2).
        var cooldownKey = $"{EnqueueCooldownPrefix}{workspaceId}";
        if (unscoredIds.Count == 0 || await cache.GetAsync(cooldownKey, ct) is not null)
            return;

        await cache.SetAsync(
            cooldownKey,
            [1],
            new DistributedCacheEntryOptions { AbsoluteExpirationRelativeToNow = EnqueueCooldown },
            ct);
        await EnsureDealAnalysisEntitiesAsync(unscoredIds, workspaceId, userId, ct);
        _ = mlRecalc.EnqueueAsync(unscoredIds, userId, workspaceId);
    }

    private static List<RiskItemDto> BuildRiskItems(
        IReadOnlyList<int> activeDealIds,
        IReadOnlyDictionary<int, MlScoreDto> mlScores,
        IReadOnlyDictionary<int, Dictionary<string, string?>> dealProps,
        IReadOnlyDictionary<int, Dictionary<string, string?>> clientProps,
        IReadOnlyDictionary<int, int> dealClientMap)
    {
        var items = new List<RiskItemDto>();
        foreach (var id in activeDealIds)
        {
            if (!mlScores.TryGetValue(id, out var score) || score.ClosureScore is null) continue;

            var closure    = score.ClosureScore.Value;
            var title      = Prop(dealProps, id, "title") ?? $"Deal #{id}";
            var clientName = ClientNameFor(dealClientMap, clientProps, id, "company_name", "name", "first_name");

            items.Add(new RiskItemDto(
                id, title, Math.Round(closure, 4), DealValue(dealProps, id), RiskBucketFor(closure), clientName));
        }

        return items;
    }

    private static string RiskBucketFor(double closureScore) =>
        closureScore < 0.4 ? "high"
        : closureScore <= 0.7 ? "medium"
        : "low";

    /// <summary>First non-null of <paramref name="nameFields"/> on the client linked to the deal, else null.</summary>
    private static string? ClientNameFor(
        IReadOnlyDictionary<int, int> dealClientMap,
        IReadOnlyDictionary<int, Dictionary<string, string?>> clientProps,
        int dealId,
        params string[] nameFields)
    {
        if (!dealClientMap.TryGetValue(dealId, out var clientId)) return null;

        return nameFields
            .Select(field => Prop(clientProps, clientId, field))
            .FirstOrDefault(name => name is not null);
    }

    private static Dictionary<string, RiskBucketDto> BuildRiskBuckets(IReadOnlyList<RiskItemDto> items) =>
        new()
        {
            ["high"]   = MakeRiskBucket(items, "high"),
            ["medium"] = MakeRiskBucket(items, "medium"),
            ["low"]    = MakeRiskBucket(items, "low"),
        };

    private static RiskBucketDto MakeRiskBucket(IReadOnlyList<RiskItemDto> items, string bucket)
    {
        var inBucket = items.Where(i => i.RiskBucket == bucket).ToList();
        var share    = items.Count > 0 ? Math.Round((double)inBucket.Count / items.Count, 4) : 0.0;
        return new RiskBucketDto(inBucket.Count, inBucket.Sum(i => i.Value), share);
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Trends (6 rolling months)
    // ──────────────────────────────────────────────────────────────────────────

    public async Task<TrendsDto> GetTrendsAsync(
        int userId, int workspaceId, CancellationToken ct)
    {
        await RequirePermissionAsync(userId, workspaceId, ViewAnalytics, ct);

        var dealIds   = await GetEntityIdsAsync(workspaceId, "deal", ct);
        var dealProps = await GetPropertyValuesAsync(dealIds, ["status", "deal_value", "expected_close"], ct);

        var months  = RollingMonths(DateTime.UtcNow, 6);
        var tallies = months.ToDictionary(m => m, _ => new MonthTally());

        var windowStart = months[0];
        var windowEnd   = months[^1].AddMonths(1);

        foreach (var id in dealIds)
        {
            var closeMonth = CloseMonthInWindow(dealProps, id, windowStart, windowEnd);
            if (closeMonth is null) continue;

            tallies[closeMonth.Value].Add(DealStatus(dealProps, id), DealValue(dealProps, id));
        }

        return new TrendsDto(months.Select(m => ToTrendsMonth(m, tallies[m])).ToList());
    }

    private sealed class MonthTally
    {
        public int NewDeals { get; private set; }
        public int ClosedWon { get; private set; }
        public int ClosedLost { get; private set; }
        public decimal WonRevenue { get; private set; }
        public decimal ActiveValue { get; private set; }

        public void Add(string status, decimal value)
        {
            NewDeals++;

            if (status == "closed")       { ClosedWon++; WonRevenue += value; }
            else if (status == "revoked") ClosedLost++;
            else                          ActiveValue += value;
        }
    }

    private static List<DateOnly> RollingMonths(DateTime now, int count) =>
        Enumerable.Range(0, count)
            .Select(i => now.AddMonths(-(count - 1) + i))
            .Select(d => new DateOnly(d.Year, d.Month, 1))
            .ToList();

    private static DateOnly? CloseMonthInWindow(
        IReadOnlyDictionary<int, Dictionary<string, string?>> props,
        int id, DateOnly windowStart, DateOnly windowEnd)
    {
        var rawClose = Prop(props, id, "expected_close");
        if (rawClose is null || !DateOnly.TryParse(rawClose, out var closeDate)) return null;

        var closeMonth = new DateOnly(closeDate.Year, closeDate.Month, 1);
        return closeMonth < windowStart || closeMonth >= windowEnd ? null : closeMonth;
    }

    private static TrendsMonthDto ToTrendsMonth(DateOnly month, MonthTally t) =>
        new(month.ToString("MMM yyyy"),
            t.NewDeals, t.ClosedWon, t.ClosedLost, t.WonRevenue, t.ActiveValue);

    // ──────────────────────────────────────────────────────────────────────────
    // Top entities
    // ──────────────────────────────────────────────────────────────────────────

    public async Task<TopEntitiesDto> GetTopEntitiesAsync(
        int userId, int workspaceId, CancellationToken ct)
    {
        await RequirePermissionAsync(userId, workspaceId, ViewAnalytics, ct);

        var dealIds   = await GetEntityIdsAsync(workspaceId, "deal",   ct);
        var clientIds = await GetEntityIdsAsync(workspaceId, "client", ct);

        var dealProps   = await GetPropertyValuesAsync(dealIds,   ["title", "deal_value", "deal_stage", "priority", "status"], ct);
        var clientProps = await GetPropertyValuesAsync(clientIds, ["company_name", "name", "industry", "client_status"], ct);

        var topDeals   = await BuildTopDealsAsync(dealIds, dealProps, ct);
        var topClients = await BuildTopClientsAsync(dealIds, clientIds, dealProps, clientProps, ct);

        return new TopEntitiesDto(topDeals, topClients);
    }

    private async Task<List<TopDealDto>> BuildTopDealsAsync(
        List<int> dealIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> dealProps,
        CancellationToken ct)
    {
        var top10DealIds = dealIds
            .OrderByDescending(id => DealValue(dealProps, id))
            .Take(10)
            .ToList();

        var mlScores = await mlClient.ScoreBatchAsync(top10DealIds, ct);

        var dealClientRels = await db.EntityRelationships
            .Where(er => top10DealIds.Contains(er.SourceEntityId) && er.RelationshipType.Name == "deal_client")
            .Select(er => new { er.SourceEntityId, er.TargetEntityId })
            .ToListAsync(ct);

        var relClientIds   = dealClientRels.Select(r => r.TargetEntityId).Distinct().ToList();
        var relClientProps = await GetPropertyValuesAsync(relClientIds, ["company_name", "name"], ct);
        var dealClientMap  = dealClientRels.ToDictionary(r => r.SourceEntityId, r => r.TargetEntityId);

        return top10DealIds
            .Select(id => ToTopDeal(id, dealProps, relClientProps, dealClientMap, mlScores))
            .ToList();
    }

    private static TopDealDto ToTopDeal(
        int id,
        IReadOnlyDictionary<int, Dictionary<string, string?>> dealProps,
        IReadOnlyDictionary<int, Dictionary<string, string?>> clientProps,
        IReadOnlyDictionary<int, int> dealClientMap,
        IReadOnlyDictionary<int, MlScoreDto> mlScores)
    {
        var score      = mlScores.TryGetValue(id, out var s) ? s.ClosureScore : null;
        var clientName = ClientNameFor(dealClientMap, clientProps, id, "company_name", "name");

        return new TopDealDto(
            id,
            Prop(dealProps, id, "title") ?? $"Deal #{id}",
            DealValue(dealProps, id),
            Prop(dealProps, id, "deal_stage"),
            RoundScore(score),
            clientName,
            Prop(dealProps, id, "priority"));
    }

    private static double? RoundScore(double? score) =>
        score.HasValue ? Math.Round(score.Value, 4) : null;

    private readonly record struct ClientLtv(int ClientId, decimal Value, bool IsExpected);

    private async Task<List<TopClientDto>> BuildTopClientsAsync(
        List<int> dealIds,
        List<int> clientIds,
        IReadOnlyDictionary<int, Dictionary<string, string?>> dealProps,
        IReadOnlyDictionary<int, Dictionary<string, string?>> clientProps,
        CancellationToken ct)
    {
        // Compute LTV per client as sum of closed deal values
        var allClientDealRels = await db.EntityRelationships
            .Where(er => dealIds.Contains(er.SourceEntityId)
                         && clientIds.Contains(er.TargetEntityId)
                         && er.RelationshipType.Name == "deal_client")
            .Select(er => new { er.SourceEntityId, er.TargetEntityId })
            .ToListAsync(ct);

        var clientDealMap = allClientDealRels
            .GroupBy(r => r.TargetEntityId)
            .ToDictionary(g => g.Key, g => g.Select(r => r.SourceEntityId).ToList());

        var topLtvs = clientIds
            .Select(id => ComputeClientLtv(id, clientDealMap, dealProps))
            .Where(x => x.Value > 0)
            .OrderByDescending(x => x.Value)
            .Take(10)
            .ToList();

        var linkedDealIds = topLtvs
            .SelectMany(x => clientDealMap.GetValueOrDefault(x.ClientId, []))
            .Distinct()
            .ToList();
        var mlScores = await mlClient.ScoreBatchAsync(linkedDealIds, ct);

        return topLtvs
            .Select(x => ToTopClient(x, clientProps, dealProps, clientDealMap, mlScores))
            .ToList();
    }

    private static ClientLtv ComputeClientLtv(
        int clientId,
        IReadOnlyDictionary<int, List<int>> clientDealMap,
        IReadOnlyDictionary<int, Dictionary<string, string?>> dealProps)
    {
        var deals  = clientDealMap.GetValueOrDefault(clientId, []);
        var closed = deals
            .Where(did => RawStatus(dealProps, did) == "closed")
            .Sum(did => DealValue(dealProps, did));
        if (closed > 0) return new ClientLtv(clientId, closed, false);

        var expected = deals
            .Where(did => RawStatus(dealProps, did) is "opened" or "pending")
            .Sum(did => DealValue(dealProps, did));
        return new ClientLtv(clientId, expected, true);
    }

    private static TopClientDto ToTopClient(
        ClientLtv ltv,
        IReadOnlyDictionary<int, Dictionary<string, string?>> clientProps,
        IReadOnlyDictionary<int, Dictionary<string, string?>> dealProps,
        IReadOnlyDictionary<int, List<int>> clientDealMap,
        IReadOnlyDictionary<int, MlScoreDto> mlScores)
    {
        var linked = clientDealMap.GetValueOrDefault(ltv.ClientId, []);
        var active = linked.Count(did => RawStatus(dealProps, did) is "opened" or "pending");
        var name   = Prop(clientProps, ltv.ClientId, "company_name")
                     ?? Prop(clientProps, ltv.ClientId, "name")
                     ?? $"Client #{ltv.ClientId}";

        return new TopClientDto(
            ltv.ClientId, name, Prop(clientProps, ltv.ClientId, "industry"),
            ltv.Value, ltv.IsExpected, active, AverageClosureScore(linked, mlScores));
    }

    private static double? AverageClosureScore(
        IEnumerable<int> dealIds, IReadOnlyDictionary<int, MlScoreDto> mlScores)
    {
        var scores = dealIds
            .Where(did => mlScores.TryGetValue(did, out var ms) && ms.ClosureScore.HasValue)
            .Select(did => mlScores[did].ClosureScore!.Value)
            .ToList();

        return scores.Count > 0 ? Math.Round(scores.Average(), 4) : null;
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Member activity
    // ──────────────────────────────────────────────────────────────────────────

    public async Task<IReadOnlyList<MemberActivityDto>> GetMemberActivityAsync(
        int userId, int workspaceId, CancellationToken ct)
    {
        await RequirePermissionAsync(userId, workspaceId, ViewTeamAnalytics, ct);

        // Members with role names
        var members = await db.UserRoleWorkspaces
            .Where(urw => urw.WorkspaceId == workspaceId && !urw.IsArchived)
            .Select(urw => new { urw.UserId, urw.Role.Name })
            .ToListAsync(ct);

        var memberUserIds = members.Select(m => m.UserId).Distinct().ToList();

        var userDetails = await db.Users
            .Where(u => memberUserIds.Contains(u.Id))
            .Select(u => new { u.Id, u.FirstName, u.LastName })
            .ToDictionaryAsync(u => u.Id, ct);

        // Deals and tasks created by each user in this workspace
        var dealsByUser = await db.EntityWorkspaces
            .Where(ew => ew.WorkspaceId == workspaceId
                         && !ew.Entity.IsArchived
                         && ew.Entity.EntityType.Name == "deal")
            .GroupBy(ew => ew.Entity.CreatedByUserId)
            .Select(g => new { UserId = g.Key, Count = g.Count() })
            .ToDictionaryAsync(x => x.UserId, x => x.Count, ct);

        var taskCreators = await db.EntityWorkspaces
            .Where(ew => ew.WorkspaceId == workspaceId
                         && !ew.Entity.IsArchived
                         && ew.Entity.EntityType.Name == "task")
            .Select(ew => new { ew.Entity.Id, ew.Entity.CreatedByUserId })
            .ToListAsync(ct);

        var taskEntityIds = taskCreators.Select(t => t.Id).Distinct().ToList();
        var taskProps     = await GetPropertyValuesAsync(taskEntityIds, ["task_status"], ct);

        var tasksByUser     = taskCreators.GroupBy(t => t.CreatedByUserId).ToDictionary(g => g.Key, g => g.Count());
        var tasksDoneByUser = taskCreators
            .Where(t => string.Equals(Prop(taskProps, t.Id, "task_status"),
                        "done", StringComparison.OrdinalIgnoreCase))
            .GroupBy(t => t.CreatedByUserId)
            .ToDictionary(g => g.Key, g => g.Count());

        return members
            .GroupBy(m => m.UserId)
            .Select(g =>
            {
                var uid  = g.Key;
                var role = g.OrderBy(x => x.Name).First().Name;
                var u    = userDetails.GetValueOrDefault(uid);
                var full = u != null ? $"{u.FirstName} {u.LastName}".Trim() : $"User #{uid}";
                return new MemberActivityDto(
                    uid, full, role,
                    dealsByUser.GetValueOrDefault(uid),
                    tasksByUser.GetValueOrDefault(uid),
                    tasksDoneByUser.GetValueOrDefault(uid));
            })
            .ToList();
    }

    private async Task EnsureDealAnalysisEntitiesAsync(
        IReadOnlyList<int> dealIds, int workspaceId, int userId, CancellationToken ct)
    {
        var analysisType = await db.EntityTypes
            .AsNoTracking()
            .FirstOrDefaultAsync(t => t.Name == "deal_analysis", ct);
        if (analysisType is null) return;

        var relType = await db.EntityRelationshipTypes
            .AsNoTracking()
            .FirstOrDefaultAsync(rt => rt.Name == "deal_analysis", ct);
        if (relType is null) return;

        var linkedDealIds = await db.EntityRelationships
            .Where(er => dealIds.Contains(er.SourceEntityId) && er.RelationshipTypeId == relType.Id)
            .Select(er => er.SourceEntityId)
            .ToHashSetAsync(ct);

        var missing = dealIds.Where(id => !linkedDealIds.Contains(id)).ToList();
        if (missing.Count == 0) return;

        var newEntities = missing
            .Select(_ => new Relativa.Persistence.Entities.Entity
            {
                EntityTypeId    = analysisType.Id,
                CreatedByUserId = userId,
                IsArchived      = false,
            })
            .ToList();
        db.Entities.AddRange(newEntities);
        await db.SaveChangesAsync(ct);

        for (int i = 0; i < missing.Count; i++)
        {
            db.EntityWorkspaces.Add(new Relativa.Persistence.Entities.EntityWorkspace
            {
                EntityId    = newEntities[i].Id,
                WorkspaceId = workspaceId,
            });
            db.EntityRelationships.Add(new Relativa.Persistence.Entities.EntityRelationship
            {
                SourceEntityId     = missing[i],
                TargetEntityId     = newEntities[i].Id,
                RelationshipTypeId = relType.Id,
            });
        }
        await db.SaveChangesAsync(ct);
    }
}
