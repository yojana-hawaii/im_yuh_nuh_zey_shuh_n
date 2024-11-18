use Immunization
go
--drop table if exists immunization.dbo.cdc_vaccine_list;
--go

/* Pull data from https://www2a.cdc.gov/vaccines/iis/iisstandards/downloads/NDC/get_all_ndc_display.txt
	Update the table if new vaccine approved by FDA and listed in CDC page above.
	If not listed in the page, mark it as inactive.
*/
create table immunization.dbo.cdc_vaccine_list (
	SequenceNumber		int				not null,
	Sale_NDC11			varchar(13)		not null,
	SaleProprietaryName varchar(100)	not null,
	SaleLabeler			varchar(100)	not null,
	StartDate			date			not null,
	EndDate				date			not null,
	SaleGTIN			int				not null,
	SaleLastUpdate		date			not null,
	UseNDC11			varchar(13)		not null,
	NoUseNDC			varchar(13)		not null,
	UseGTIN				int				not null,
	UseLastUpdate		date			not null,
	CVXCode				int				not null,
	CXVDescription		varchar(100)	not null,
	MVXCode				varchar(10)		not null,
	Active				bit				not null = 1
);
go 

select * 
from immunization.dbo.cdc_vaccine_list;

