use DStruct

insert into access.Tenant(Name) values(N'test_tenant1');
insert into access.TenantKey(TenantID, [Key]) values(SCOPE_IDENTITY(), N'apikey1');
GO

insert into access.Tenant(Name) values(N'test_tenant2');
insert into access.TenantKey(TenantID, [Key]) values(SCOPE_IDENTITY(), N'apikey2');
GO

-- should return 1
exec access.Authenticate @TenantName = N'test_tenant1', @TenantKey = N'apikey1';
-- should all return 0
exec access.Authenticate @TenantName = N'test_tenant2', @TenantKey = N'apikey1';
exec access.Authenticate @TenantName = N'test_tenant0', @TenantKey = N'apikey1';
exec access.Authenticate @TenantName = N'test_tenant0', @TenantKey = N'apikey0';
GO
