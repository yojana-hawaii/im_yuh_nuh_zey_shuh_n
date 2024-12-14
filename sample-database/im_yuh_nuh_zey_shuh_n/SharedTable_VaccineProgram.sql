use Immunization
go
--drop table if exists Immunization.dbo.VaccineSource;
--go

/**
Vaccine Program - VFC (Vaccine for Children), VFA (Vaccine for Adult)
Funding Source - Federal, State, Private (Health Center Purchased), Donated
Do I need to separate this or keep it as same enum
**/
create table Immunization.dbo.VaccineSource
(
	VaccineSourceId int identity(1,1) primary key,
	VaccineSource varchar(100) not null,
);
go
insert into immunization.dbo.VaccineSource
select 'VFC'
union
select 'VFA'
union
select 'Federal'
union
select 'State'
union
select 'Private'
union
select 'Donated'
go
select * from Immunization.dbo.VaccineSource;
go