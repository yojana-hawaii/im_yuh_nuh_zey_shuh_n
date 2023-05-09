

use Immunization
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

drop table if exists [Immunization].[dbo].[VaccineGroup]
go
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

--	exec [dbo].[ssis_VaccineGroup]
--	select * from [Immunization].[dbo].[VaccineGroup]


SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

drop proc if exists [dbo].[ssis_VaccineGroup]
go
create proc [dbo].[ssis_VaccineGroup]
as begin

;with u as (

	select distinct  VaccineCVX_ID, VaccineCVX, Vaccine, VisDate
	from dbo.ImmunizationSetup
) 

merge [Immunization].[dbo].[VaccineGroup] as t
	using u on t.VaccineCVX_ID = u.VaccineCVX_ID
when matched and 
(
	t.Vaccine <> u.Vaccine or
	t.VaccineCVX <> u.VaccineCVX or
	t.VisDate <> u.VisDate
)
then update set
	t.Vaccine = u.Vaccine,
	t.VaccineCVX = u.VaccineCVX,
	t.VisDate = u.VisDate,
	t.ActiveVaccineGroup = 1

when not matched by target
then insert (VaccineCVX_ID, VaccineCVX, Vaccine, VisDate, ActiveVaccineGroup)
values (VaccineCVX_ID, VaccineCVX, Vaccine, VisDate, 1)

when not matched by source
then update	set 
	ActiveVaccineGroup = 0

;

end

go

exec Immunization.dbo.ssis_VaccineGroup
go

select * from Immunization.dbo.VaccineGroup

go