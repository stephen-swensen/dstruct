use master;
GO

drop database if exists DStruct;
create database DStruct;
GO

use DStruct;
GO

create schema access;
GO

create table access.Tenant
(
    TenantID int identity (1,1) primary key,
    [Name] nvarchar(255) not null,
    unique (Name)
);
GO

-- i.e. active api keys
create table access.TenantKey
(
    -- primary keys are automatically indexed and clustered
    -- (i.e. physical row storage) if no other clustered index
    -- is given.
    TenantKeyID int identity (1,1) primary key,
    TenantID int not null index IX_TenantKey_TenantID nonclustered,
    -- maybe make this an encrypted column
    [Key] nvarchar(255) not null,
    foreign key (TenantID) references access.Tenant(TenantID)
);

GO

create schema stack;
GO

-- intentionally denormalized since a parent Stack
-- table would be low-value book-keeping
create table stack.Item
(
    -- bigint because will have potentially lots-o-records
    ItemID bigint identity (1,1) primary key,
    -- use Row Level Security to filter
    TenantID int not null index IX_Item_TenantID nonclustered,
    -- a loose identifier for the stack itself
    StackID nvarchar(255) not null index IX_Item_StackID,
    -- expecting this to be json, but could be anything perhaps
    Value nvarchar(max),
    foreign key (TenantID) references access.Tenant(TenantID),
    index IX_Item_TenantID_StackID nonclustered (TenantID, StackID)
);

GO
