use Immunization
go

--drop table [Immunization].[dbo].[VaccineGroup]
--go
create table [Immunization].[dbo].[VaccineGroup]
(
	VaccineGroupID int identity(1,1) primary key,
	VaccineCVX_ID nvarchar(255) not null, 
	VaccineCVX int not null, 
	Vaccine nvarchar(30) not null, 
	VisDate date not null,
	ActiveVaccineGroup int not null
)
go
select * 
from [Immunization].dbo.VaccineGroup;
go