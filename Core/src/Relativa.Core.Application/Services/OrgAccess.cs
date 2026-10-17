using Relativa.Core.Application.Exceptions;
using Relativa.Core.Domain.Interfaces;
using Relativa.Persistence.Entities;

namespace Relativa.Core.Application.Services;

public static class OrgAccess
{
    public static async Task<UserRoleOrganization> RequireMembership(
        IUserRoleOrganizationRepository repository,
        int userId,
        int orgId,
        CancellationToken ct)
    {
        return await repository.GetAsync(userId, orgId, ct)
            ?? throw new AppException("not_org_member", 403, "You are not a member of this organization.");
    }

    public static async Task RequirePermission(
        IUserRoleOrganizationRepository repository,
        int userId,
        int orgId,
        string permission,
        CancellationToken ct)
    {
        var membership = await RequireMembership(repository, userId, orgId, ct);
        var hasPermission = membership.Role?.RolePermissions
            .Any(rp => rp.Permission?.Name == permission) ?? false;
        if (!hasPermission)
            throw new AppException("permission_denied", 403, $"You do not have the '{permission}' permission in this organization.");
    }
}
