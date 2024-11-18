
use Immunization
go

--drop view if exists dbo.ViewImminizationGiven;
--go

create view dbo.ViewImminizationGiven
as
select 
	grp.vaccineCvx, grp.Vaccine, grp.VisDate, grp.ActiveVaccineGroup,
	b.BrandCVX, b.Brand, b.Manufacturer, b.NDC, b.ActiveVaccineBrand ,
	ln.LotNumber, ln.LotExpiration, ln.LotNumberAddedBy, ln.LotNumberAddedDate, ln.ActiveLotNumber,
	g.PID, g.SDID, g.AdministeredDate, g.LOC, g.Facility 
from Immunization.dbo.VaccineGroup grp
	left join Immunization.dbo.vaccineBrand b on b.VaccineCVX_ID = grp.VaccineCVX_ID
	left join Immunization.dbo.VaccineLotNumber ln on ln.BrandCVX_ID = b.BrandCVX_ID
	left join Immunization.dbo.VaccineGiven g on g.LotNumber_ID = ln.LotNumber_ID  
-- where tenantId = @tenantId



go

select * from Immunization.dbo.ViewImminizationGiven

go