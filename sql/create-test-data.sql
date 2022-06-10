use DStruct

insert into access.Tenant(Name) values(N'test_tenant1');
insert into access.TenantKey(TenantID, [Key]) values(SCOPE_IDENTITY(), N'apikey1');
GO

insert into access.Tenant(Name) values(N'test_tenant2');
insert into access.TenantKey(TenantID, [Key]) values(SCOPE_IDENTITY(), N'apikey2');
GO
