
use Immunization
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


drop proc if exists dbo.[ssis_VaccineLotNumber]
go
create proc dbo.[ssis_VaccineLotNumber]
as begin

;with u as (
	select distinct   VaccineCVX_ID, BrandCVX_ID, LotNumber_ID, LotNumber, LotExpiration, LotNumberAddedBy, LotNumberAddedDate
	from Immunization.dbo.ImmunizationSetup
)

merge [Immunization].[dbo].[VaccineLotNumber] t
	using u on t.LotNumber_ID = u.LotNumber_ID  --and t.ActiveLotNumber = u.Active

when matched and
(
	t.VaccineCVX_ID <> u.VaccineCVX_ID or
	t.BrandCVX_ID <> u.BrandCVX_ID or
	t.LotNumber_ID <> u.LotNumber_ID or
	t.LotNumber <> u.LotNumber or
	t.LotExpiration <> u.LotExpiration or
	t.LotNumberAddedBy <> u.LotNumberAddedBy or
	t.LotNumberAddedDate <> u.LotNumberAddedDate 
	--t.ActiveLotNumber <> u.Active
)
then update set
	t.VaccineCVX_ID = u.VaccineCVX_ID,
	t.BrandCVX_ID = u.BrandCVX_ID,
	t.LotNumber_ID = u.LotNumber_ID,
	t.LotNumber = u.LotNumber,
	t.LotExpiration = u.LotExpiration,
	t.LotNumberAddedBy = u.LotNumberAddedBy,
	t.LotNumberAddedDate = u.LotNumberAddedDate
	--t.ActiveLotNumber = u.Active

when not matched by target
then insert (VaccineCVX_ID, BrandCVX_ID, LotNumber_ID, 
	LotNumber, LotExpiration, LotNumberAddedBy, LotNumberAddedDate,ActiveLotNumber)
values (VaccineCVX_ID, BrandCVX_ID, LotNumber_ID, 
	LotNumber, LotExpiration, LotNumberAddedBy, LotNumberAddedDate,1)
when not matched by source
then update set
	ActiveLotNumber = 0
;
end
go

exec Immunization.dbo.[ssis_VaccineLotNumber]
	
go

select * from [Immunization].[dbo].[VaccineLotNumber]

go