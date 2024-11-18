
use Immunization
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


drop proc if exists [dbo].[ssis_VaccineGiven]
go

create proc [dbo].[ssis_VaccineGiven]
as begin

declare @StartDate date = '2023-01-01', @EndDate date = convert(date, getDate() );
; with immGiven as (
	select distinct
		h.VaccineCVX_ID, h.BrandCVX_ID,h.LotNumber_ID,
		case when LotNumber_ID is null then 0 else 1 end ActiveInSetup,
		t.ImmunizationId, t.PID, t.SDID, t.Brand, CVXCode, t.LotNumber, 
		t.ExpirationDate, t.AdministeredDate, t.LoC, t.Facility
	from Immunization.dbo.ImmunizationGiven t
		left join Immunization.dbo.ImmunizationSetup h 
					on h.Brand = t.Brand 
						and h.LotNumber = t.LotNumber 
						and h.LotExpiration = t.ExpirationDate
	where
		AdministeredDate >= @StartDate
		and AdministeredDate <= @EndDate
		and wasGiven = 'Y'
		and Historical = 'N'
) --select * from immGiven where ImmunizationId = 1872328689874430
, unmatched as (
	select distinct
		case 
			when h.VaccineCVX_ID is not null then h.VaccineCVX_ID
			when h.CVXCode in (141,153) then 'GE.IMM.CUSL.1734341538050570.1704999537083440'
			when h.CVXCode in ('03') then 'GE.IMM.CUSL.1734341538050570.1704995622081930'
			--when h.CVXCode in ('120') then 'GE.IMM.CUSL.1734341538050570.1704903115069410'
			--when h.CVXCode in ('110') then 'GE.IMM.CUSL.1734341538050570.1704903115069410'
			--when h.CVXCode in ('104') then 'GE.IMM.CUSL.1734341538050570.1704908206073030'
			else h1.VaccineCVX_ID 
		end VaccineCVX_ID, 
		case
			when h.BrandCVX_ID is not null then h.BrandCVX_ID
			when h.CVXCode in (141,153) then 'GE.IMM.CUSL.1734341538050570.1704999537083440.' + replace(h.Brand, ' ', '_')
			when h.CVXCode in ('03') then 'GE.IMM.CUSL.1734341538050570.1704995622081930.1751292782607390'
			--when h.CVXCode in ('120') then 'GE.IMM.CUSL.1734341538050570.1704903115069410.1704903117070590'
			--when h.CVXCode in ('110') then 'GE.IMM.CUSL.1734341538050570.1704903115069410.1704903117070400'
			--when h.CVXCode in ('104') then 'GE.IMM.CUSL.1734341538050570.1704908206073030'+ '.' + replace(h.Brand, ' ', '_')

			else h1.VaccineCVX_ID + '.' + replace(h.Brand, ' ', '_')
		end BrandCVX_ID,
		h.LotNumber_ID,
		case when h.LotNumber_ID is null then 0 else 1 end ActiveInSetup,
		h.ImmunizationId, h.PID, h.SDID, h.Brand, h.CVXCode, h.LotNumber, h.ExpirationDate, h.AdministeredDate, h.LoC, h.Facility
	from immGiven h
		left join Immunization.dbo.ImmunizationSetup h1 on h1.BrandCVX = h.CVXCode

) --select * from unmatched where ImmunizationId = 1872497093729430
, u as (
	select distinct
		h.VaccineCVX_ID, h.BrandCVX_ID, 
		case 
			when h.LotNumber_ID is not null then h.LotNumber_ID
			else h.BrandCVX_ID + '.' + h.LotNumber
			end LotNumber_ID,
		h.ActiveInSetup, 
		h.ImmunizationId, h.PID, h.SDID, h.Brand, h.CVXCode, h.LotNumber, h.ExpirationDate, h.AdministeredDate, h.LoC, h.facility
	from unmatched h
)
--select * into #temp from u
--exec tempdb.dbo.sp_help N'#temp'

merge [Immunization].[dbo].[VaccineGiven] as t
	using u on t.ImmunizationID = u.ImmunizationID and isnull(t.LotNumber_ID,'') = isnull(u.LotNumber_ID,'')

when matched and
(
	t.VaccineCVX_ID <> u.VaccineCVX_ID or
	t.BrandCVX_ID <> u.BrandCVX_ID or
	t.LotNumber_ID <> u.LotNumber_ID or
	t.ActiveInSetup <> u.ActiveInSetup or
	t.PID <> u.PID or
	t.SDID <> u.SDID or
	t.Brand <> u.Brand or
	t.CVXCode <> u.CVXCode or
	t.LotNumber <> u.LotNumber or
	t.ExpirationDate <> u.ExpirationDate or
	t.AdministeredDate <> u.AdministeredDate or
	t.LOC <> u.LOC or 
	t.facility <> u.facility
)
then update set
	t.VaccineCVX_ID = u.VaccineCVX_ID,
	t.BrandCVX_ID = u.BrandCVX_ID,
	t.LotNumber_ID = u.LotNumber_ID,
	t.ActiveInSetup = u.ActiveInSetup,
	t.PID = u.PID,
	t.SDID = u.SDID,
	t.Brand = u.Brand,
	t.CVXCode = u.CVXCode,
	t.LotNumber = u.LotNumber,
	t.ExpirationDate = u.ExpirationDate,
	t.AdministeredDate = u.AdministeredDate,
	t.LOC = u.LOC,
	t.facility = u.facility

when not matched by target then
insert (VaccineCVX_ID, BrandCVX_ID,LotNumber_ID, ActiveInSetup, ImmunizationID, PID, SDID, Brand, 
	CVXCode, LotNumber, ExpirationDate,  AdministeredDate, LOC, Facility)
values (VaccineCVX_ID, BrandCVX_ID,LotNumber_ID, ActiveInSetup, ImmunizationID, PID, SDID, Brand, 
	CVXCode, LotNumber, ExpirationDate,  AdministeredDate, LOC, Facility)

when not matched by source then delete;

end

go
exec Immunization.[dbo].[ssis_VaccineGiven]
go

select * from Immunization.dbo.VaccineGiven

go