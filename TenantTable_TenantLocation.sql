
use Immunization
go
create table Immunization.dbo.TenantLocation
(
	LocationId int identity(1,1),
	LocationName varchar(100) not null,
);
go
select * from Immunization.dbo.TenantLocation
go
/**example - building A, Building B, Pediatrics department etc.
Centricity has facility and it is subdivided into LOC (location of care). Example Faclity-A has LOC-A1, LOC-A2 etc. Inventory could be based on Facility or LOC. Different health center might do it differently
Athena as departments. Multiple department might share same address. Inventory could be based on department or shared address.
**/
