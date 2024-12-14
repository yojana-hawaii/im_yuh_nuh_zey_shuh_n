

use Immunization
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


drop proc if exists dbo.[ssis_VaccineBrand]
go
create proc dbo.[ssis_VaccineBrand]
as begin

;with u as (
	select distinct VaccineCVX_ID, BrandCVX_ID, BrandCVX, Brand, BodySite, Dose, Manufacturer, NDC,Route, Unit, OrderDescription,   ICD10Code
	from Immunization.dbo.ImmunizationSetup
)

merge [Immunization].[dbo].[VaccineBrand] as t
	using u on t.BrandCVX_ID = u.BrandCVX_ID 
					and isnull(t.Dose,'') = isnull(u.Dose,'') 
					and t.Brand = u.Brand 
					and isnull(t.Route,'') = isnull(u.Route,'')
when matched and
(
	t.VaccineCVX_ID <> u.VaccineCVX_ID or
	t.BrandCVX <> u.BrandCVX or
	t.BodySite <> u.BodySite or
	t.Manufacturer <> u.Manufacturer or
	t.NDC <> u.NDC or
	t.Unit <> u.Unit or
	t.OrderDescription <> u.OrderDescription or
	t.ICD10Code <> u.ICD10Code
)
then update set
	t.VaccineCVX_ID = u.VaccineCVX_ID,
	t.BrandCVX = u.BrandCVX,
	t.BodySite = u.BodySite,
	t.Manufacturer = u.Manufacturer,
	t.NDC = u.NDC,
	t.Unit = u.Unit,
	t.OrderDescription = u.OrderDescription,
	t.ICD10Code = u.ICD10Code,
	t.ActiveVaccineBrand = 1

when not matched by target 
then insert (BrandCVX_ID,VaccineCVX_ID,BrandCVX,Brand,BodySite,Dose,
		Manufacturer,NDC,Route,Unit,OrderDescription,
		ICD10Code,ActiveVaccineBrand)
values (BrandCVX_ID,VaccineCVX_ID,BrandCVX,Brand,BodySite,Dose,
		Manufacturer,NDC,Route,Unit,OrderDescription,
		ICD10Code,1)

when not matched by source 
then update set
	ActiveVaccineBrand = 0
;
end
go

exec Immunization.dbo.[ssis_VaccineBrand]
go

select * from Immunization.dbo.VaccineBrand

go