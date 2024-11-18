use Immunization
go


create table [Immunization].[dbo].[VaccineGiven]
(
	VaccineGivenID int Identity(1,1) not null,
	VaccineCVX_ID nvarchar(255) null, 
	BrandCVX_ID nvarchar(255) null, 
	LotNumber_ID nvarchar(255) null,
	ActiveInSetup int not null,
	ImmunizationID numeric(19,0) not null,
	PID numeric(19,0) not null,
	SDID numeric(19,0) not null,
	Brand nvarchar(255) not null,
	CVXCode nvarchar(4) not null, 
	LotNumber nvarchar(20) not null,
	ExpirationDate date not null,
	AdministeredDate date not null,
	LOC nvarchar(50) null,
	Facility nvarchar(50) null
)
go

drop proc if exists dbo.ssis_ImmunizationGiven;
go

create proc dbo.ssis_ImmunizationGiven
as 
begin
truncate table dbo.ImmunizationGiven;

	drop table if exists #vaccineInfo;
	select * 
	into #vaccineInfo
	from (
		select  
			vaccine,  NDC, LotNumber,
			rowNum = ROW_NUMBER() over(partition by vaccine, LotNumber order by NDC )
		from (
			select distinct s.Vaccine, s.NDC, s.LotNumber
			from Immunization.dbo.ImmunizationSetup s
			where LotNumber is not null
		) x ) y
	where rowNum = 1

	--select * from #vaccineInfo
	

	insert into dbo.ImmunizationGiven
	(
		VaccineGroup,FormUsed,Dose,Historical,HistoricalSource,wasGiven,ImmunizationId,PID,SDID,Brand,CVXCode,
		Series,VFCEligibility,Manufacturer,ManuFacturerCode,GPI,NDC,LotNumber,VaccineSite,
		ExpirationDate,Providers,AdministeredBy,AdministeredDate,LoC, Facility,AdministeredComments,ReasonNotGiven
	)
		select  distinct VaccineGroupName,
			case when Historical = 'Y' then -1 
				when historical = 'N' and  AdministeredComments  like '%obs%' then 0
				when wasGiven = 'N' then -2
				else 1
			end Form_Used,
			AdministeredDose Dose,
			i.Historical Historical,
			case when i.HistoricalSource = '' then null else convert(varchar(50),i.HistoricalSource) end HistoricalSource ,
			i.wasGiven wasGiven,
			i.ImmunizationId ImmunizationId,
			i.PID PID, 
			i.SDID SDID,
			convert(varchar(100), i.VaccineName) Brand, 
			i.CVXCode CVXCode,
			i.Series Series, 
			case when i.VFCEligibility = '' then null else convert(varchar(10), i.VFCEligibility) end VFCEligibility, 
			case when i.Manufacturer = '' then null else convert(varchar(30),i.Manufacturer) end Manufacturer,
			case when i.ManuFacturerCode = '' then null else convert(varchar(10), i.ManuFacturerCode) end ManuFacturerCode,
			i.GPI GPI,
			case when i.NDC is null then v.NDC else i.NDC end NDC, 
			i.LotNumber LotNumber, i.Site,
			convert(date,i.ExpirationDate) ExpirationDate,
			pv.ListName Providers,
			df.ListName AdministeredBy,
			convert(date,i.AdministeredDate) AdministeredDate,
			doc.LoC, doc.Facility,
			case when i.AdministeredComments = '' then null else convert(varchar(100),i.AdministeredComments) end AdministeredComments,
			case when i.ReasonNotGiven = '' then null else convert(varchar(100), i.ReasonNotGiven) end ReasonNotGiven 
		from V20_sql.centricityPS.dbo.Immunization i 
			left join V20Warehouse.dbo.Document doc on i.sdid = doc.sdid
			left join V20Warehouse.dbo.patientprofile pp on pp.pid = i.pid
			left join V20Warehouse.dbo.DoctorFacility df on df.PVID = i.AdministeredByPVID
			left join V20Warehouse.dbo.DoctorFacility pv on pv.PVID = doc.PubUser
			left join #vaccineInfo v on v.lotNumber = i.LotNumber and v.Vaccine = i.VaccineGroupName

		where --wasGiven = 'Y' and 
			i.FiledInError = 'N' and i.inactive = 'N' 
			and pp.TestPatient = 0
			--and convert(date,i.AdministeredDate) > '2018-01-01'
			and convert(date,i.AdministeredDate) < DATEADD(month, 1, getdate() )
			and datediff(day, i.AdministeredDate, i.db_Create_date) > -15
			and immunizationid not in (1985869416676950/*does not show in documents or handout. right after v22 upgrade*/)

			and cvxcode is not null
end

go
exec dbo.ssis_ImmunizationGiven;

go

select top 100 * from Immunization.dbo.ImmunizationGiven

go