use Immunization
go

--drop table if exists Immunization.dbo.VaccineLotNumber
--go

create table [Immunization].[dbo].[VaccineLotNumber]
(
	VaccineLotNumberID  int identity(1,1) not null primary key,
	VaccineCVX_ID nvarchar(255) not null, 
	BrandCVX_ID nvarchar(255) not null, 
	LotNumber_ID nvarchar(255) not null, 
	LotNumber nvarchar(50) null, 
	LotExpiration date null, 
	LotNumberAddedBy nvarchar(255) null, 
	LotNumberAddedDate date null,
	ActiveLotNumber int not null,
	TenantID int,
	constraint fk_tenantId_vaccineLot foreign key (TenantID) references Tenant(TenantID)
)
go
select * from Immunization.dbo.VaccineLotNumber
go