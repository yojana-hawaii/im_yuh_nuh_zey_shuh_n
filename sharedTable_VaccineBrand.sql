use Immunization
go

--drop table if exists Immunization.dbo.VaccineBrand
--go
create table Immunization.dbo.VaccineBrand
(
	 VaccineBrandID int identity(1,1) not null primary key,
	 VaccineCVX_ID nvarchar(255) not null, 
	 BrandCVX_ID nvarchar(255) not null, 
	 BrandCVX int not null,
	 Brand nvarchar(400) null, 
	 BodySite nvarchar(max) null, 
	 Dose float null, 
	 Manufacturer nvarchar(255) null, 
	 NDC nvarchar(15) null,
	 Route nvarchar(10) null,
	 Unit nvarchar(5) null, 
	 OrderDescription nvarchar(50) null, 
	 ICD10Code nvarchar(5) null,
	 ActiveVaccineBrand int not null
)
go
select * from Immunization.dbo.VaccineBrand
go