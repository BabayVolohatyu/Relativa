using Microsoft.AspNetCore.Mvc;
using Relativa.Core.Application.DTOs.Entity;
using Relativa.Core.Application.Interfaces;
using Relativa.Core.Domain.Interfaces;
using Relativa.Core.Application.Exceptions;

namespace Relativa.Core.Endpoints;

public static class EntityEndpoints
{
    public static IEndpointRouteBuilder MapEntityEndpoints(this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/api/v1/workspaces/{workspaceId:int}/entities")
            .WithTags("Entities");

        group.MapGet("/", async (
            int workspaceId,
            int? entityTypeId,
            string? q,
            int? skip,
            int? take,
            [FromQuery(Name = "f")] string[]? f,
            [FromQuery(Name = "sort")] string[]? sort,
            int? excludeLinkedSourceRelTypeId,
            int? excludeLinkedTargetRelTypeId,
            IEntityService service,
            HttpContext httpContext,
            CancellationToken ct) =>
        {
            var userId = WorkspaceEndpoints.GetUserId(httpContext);
            var filters = ParseFilters(f);
            var sortFields = ParseSort(sort);
            var result = await service.GetByWorkspaceAsync(
                workspaceId, userId, entityTypeId, q,
                skip ?? 0, take ?? 50,
                filters, sortFields,
                excludeLinkedSourceRelTypeId, excludeLinkedTargetRelTypeId, ct);
            return Results.Ok(result);
        })
        .WithName("ListEntities")
        .WithSummary("List entities — combined filtering, sorting, and pagination")
        .Produces<EntityPagedResult>()
        .WithDescription("""
                Returns non-archived entities visible to the caller within the given workspace.

                ### Visibility (RBAC)
                A user sees only entities they created **or** entities created by users whose workspace role
                has a **lower** priority number (higher authority). Org owners bypass this and see everything.
                Requires the `view_entities` workspace permission.

                ### Combined AND-filters (`f`)
                Repeat the `f` parameter to add multiple conditions — all must match (AND logic).
                Format: `propertyId:op` or `propertyId:op:value`.

                | Data type | Allowed operators |
                |---|---|
                | String | `eq`, `neq`, `contains`, `startsWith` |
                | Int / Decimal | `eq`, `neq`, `gt`, `lt`, `gte`, `lte` |
                | Bool | `eq`, `neq` |
                | Date (yyyy-MM-dd) | `eq`, `neq`, `gt`, `lt`, `gte`, `lte` |

                **RBAC on filters:** conditions targeting `IsReadonly` properties are silently dropped
                for callers without the `view_analytics` permission — no error is returned.

                ### Sorting (`sort`)
                Repeat the `sort` parameter for multi-field ordering (applied left-to-right).
                Format: `propertyId:asc` or `propertyId:desc`. Default order is entity `id` ascending.
                Same RBAC rule applies: readonly-property sort fields are silently dropped without `view_analytics`.

                ### Pagination
                Use `skip` + `take` for offset pagination. The response always includes `total` (count
                of matching rows before pagination), so the client can calculate page count.
                Default: `skip=0`, `take=50`. Max `take=500`.

                ### Error responses
                | Status | Reason |
                |---|---|
                | 400 | Malformed `f` / `sort` string; unknown propertyId for entityType; operator incompatible with data type; unparseable value |
                | 403 | Missing `view_entities` permission or not a workspace member |
                | 404 | `entityTypeId` does not exist (only when `entityTypeId` is supplied with filters) |
                """);

        group.MapGet("/{entityId:int}", async (int workspaceId, int entityId, IEntityService service, HttpContext httpContext, CancellationToken ct) =>
        {
            var userId = WorkspaceEndpoints.GetUserId(httpContext);
            var result = await service.GetByIdAsync(entityId, workspaceId, userId, ct);
            return Results.Ok(result);
        })
        .WithName("GetEntity")
        .WithSummary("Get a single entity by id (404 if not in this workspace)")
        .Produces<EntityDetailDto>();

        group.MapPost("/", async (int workspaceId, CreateEntityRequest request, IEntityService service, HttpContext httpContext, CancellationToken ct) =>
        {
            var userId = WorkspaceEndpoints.GetUserId(httpContext);
            var result = await service.CreateAsync(workspaceId, userId, request, ct);
            return Results.Created($"/api/v1/workspaces/{workspaceId}/entities/{result.Id}", result);
        })
        .WithName("CreateEntity")
        .WithSummary("Create a new entity with property values (atomic transaction)")
        .Produces<EntityDetailDto>(StatusCodes.Status201Created)
        .ProducesValidationProblem();

        group.MapPatch("/{entityId:int}", async (int workspaceId, int entityId, UpdateEntityRequest request, IEntityService service, HttpContext httpContext, CancellationToken ct) =>
        {
            var userId = WorkspaceEndpoints.GetUserId(httpContext);
            var result = await service.UpdateAsync(entityId, workspaceId, userId, request, ct);
            return Results.Ok(result);
        })
        .WithName("UpdateEntity")
        .WithSummary("Update property values; omitted properties keep their current values. Send propertyId from GET entity or entity-types. Use null value to clear an optional field.")
        .Produces<EntityDetailDto>()
        .ProducesValidationProblem();

        group.MapDelete("/{entityId:int}", async (int workspaceId, int entityId, IEntityService service, HttpContext httpContext, CancellationToken ct) =>
        {
            var userId = WorkspaceEndpoints.GetUserId(httpContext);
            await service.ArchiveAsync(entityId, workspaceId, userId, ct);
            return Results.NoContent();
        })
        .WithName("ArchiveEntity")
        .WithSummary("Soft-delete (archive) an entity")
        .Produces(StatusCodes.Status204NoContent);

        return routes;
    }

    private static List<EntityFilterCondition> ParseFilters(string[]? raw)
    {
        if (raw is null or { Length: 0 }) return [];
        var result = new List<EntityFilterCondition>(raw.Length);
        foreach (var s in raw)
        {
            var parts = s.Split(':', 3);
            if (parts.Length < 2 || !int.TryParse(parts[0], out var pid))
                throw new AppException("invalid_filter_format", 400, 
                    $"Invalid filter format '{s}'. Expected propertyId:op or propertyId:op:value.");
            result.Add(new EntityFilterCondition(pid, parts[1], parts.Length == 3 ? parts[2] : null));
        }
        return result;
    }

    private static List<EntitySortField> ParseSort(string[]? raw)
    {
        if (raw is null or { Length: 0 }) return [];
        var result = new List<EntitySortField>(raw.Length);
        foreach (var s in raw)
        {
            var parts = s.Split(':', 2);
            if (!int.TryParse(parts[0], out var pid))
                throw new AppException("invalid_sort_format", 400, 
                    $"Invalid sort format '{s}'. Expected propertyId or propertyId:asc|desc.");
            var dir = parts.Length == 2 ? parts[1].ToLowerInvariant() : "asc";
            if (dir is not "asc" and not "desc")
                throw new AppException("invalid_sort_direction", 400, $"Invalid sort direction '{dir}'. Use 'asc' or 'desc'.");
            result.Add(new EntitySortField(pid, dir));
        }
        return result;
    }
}
