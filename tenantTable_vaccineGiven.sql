

use Immunization
go
--drop table Immunization.dbo.ImmunizationGiven
--go

create table Immunization.dbo.ImmunizationGiven
(
	FormUsed	int not null,
	Historical varchar(1) not null,
	HistoricalSource varchar(50) null,
	wasGiven varchar(1) not null,
	ImmunizationId numeric(19,0) not null primary key,
	PID numeric(19,0) not null,
	SDID numeric(19,0) not null,
	VaccineGroup varchar(100) not null,
	Brand varchar(100) null,
	CVXCode varchar(3) not null,
	Series int not null,
	VFCEligibility varchar(10) null,
	Manufacturer varchar(30) null,
	ManuFacturerCode varchar(10) null,
	GPI varchar(20) null,
	Dose decimal(12,2) null,
	NDC varchar(20) null,
	LotNumber varchar(50) null,
	ExpirationDate date null,
	Providers varchar(50) null,
	AdministeredBy varchar(50) null,
	AdministeredDate date null,
	VaccineSite varchar(50) null,
	LoC varchar(10) null,
	Facility varchar(25) null,
	AdministeredComments varchar(100) null,
	ReasonNotGiven varchar(100) null,
	TenantID int,
	constraint fk_tenantId_vaccineGiven foreign key (TenantID) references Tenant(TenantID)
)

go
select * from Immunization.dbo.ImmunizationGiven
go
