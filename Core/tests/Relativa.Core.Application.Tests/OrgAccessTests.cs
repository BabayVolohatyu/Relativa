using FluentAssertions;
using Moq;
using Relativa.Core.Application.Exceptions;
using Relativa.Core.Application.Services;
using Relativa.Core.Domain.Interfaces;
using Relativa.Persistence.Entities;
using Xunit;

namespace Relativa.Core.Application.Tests;

public sealed class OrgAccessTests
{
    private readonly Mock<IUserRoleOrganizationRepository> _repo = new();

    [Fact]
    public async Task RequireMembership_WhenMissing_ThrowsNotOrgMember()
    {
        _repo.Setup(r => r.GetAsync(1, 2, It.IsAny<CancellationToken>()))
            .ReturnsAsync((UserRoleOrganization?)null);

        var act = () => OrgAccess.RequireMembership(_repo.Object, 1, 2, CancellationToken.None);

        var error = await act.Should().ThrowAsync<AppException>();
        error.Which.Code.Should().Be("not_org_member");
        error.Which.StatusCode.Should().Be(403);
    }

    [Fact]
    public async Task RequireMembership_WhenPresent_ReturnsMembership()
    {
        var membership = new UserRoleOrganization { UserId = 1, OrganizationId = 2 };
        _repo.Setup(r => r.GetAsync(1, 2, It.IsAny<CancellationToken>())).ReturnsAsync(membership);

        var result = await OrgAccess.RequireMembership(_repo.Object, 1, 2, CancellationToken.None);

        result.Should().BeSameAs(membership);
    }

    [Fact]
    public async Task RequirePermission_WhenRoleMissing_ThrowsPermissionDenied()
    {
        _repo.Setup(r => r.GetAsync(1, 2, It.IsAny<CancellationToken>()))
            .ReturnsAsync(new UserRoleOrganization { UserId = 1, OrganizationId = 2, Role = null! });

        var act = () => OrgAccess.RequirePermission(_repo.Object, 1, 2, "manage_org", CancellationToken.None);

        (await act.Should().ThrowAsync<AppException>()).Which.Code.Should().Be("permission_denied");
    }

    [Fact]
    public async Task RequirePermission_WhenPermissionAbsent_ThrowsPermissionDenied()
    {
        _repo.Setup(r => r.GetAsync(1, 2, It.IsAny<CancellationToken>()))
            .ReturnsAsync(Member("view_org"));

        var act = () => OrgAccess.RequirePermission(_repo.Object, 1, 2, "manage_org", CancellationToken.None);

        (await act.Should().ThrowAsync<AppException>()).Which.Code.Should().Be("permission_denied");
    }

    [Fact]
    public async Task RequirePermission_WhenPermissionPresent_Completes()
    {
        _repo.Setup(r => r.GetAsync(1, 2, It.IsAny<CancellationToken>()))
            .ReturnsAsync(Member("manage_org"));

        var act = () => OrgAccess.RequirePermission(_repo.Object, 1, 2, "manage_org", CancellationToken.None);

        await act.Should().NotThrowAsync();
    }

    private static UserRoleOrganization Member(string permission) => new()
    {
        UserId = 1,
        OrganizationId = 2,
        Role = new OrganizationRole
        {
            RolePermissions =
            [
                new OrganizationRolePermission { Permission = new Permission { Name = permission } }
            ]
        }
    };
}
