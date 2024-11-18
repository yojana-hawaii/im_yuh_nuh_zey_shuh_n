
use Immunization
go
--drop table if exists immunization.dbo.Tenant
--go
create table immunization.dbo.Tenant
(
	TenantId int not null primary key,
	TenantGuid uniqueidentifier not null default newid(),
	TenantName varchar(100) not null,
)
go
select * from Immunization.dbo.Tenant
go