use Immunization
go
create table immunization.dbo.TenantPurchaseInventory
(
	ProductId int identity(1,1),
	BrandName varchar(100) not null,
	SaleBarcode varchar(15) null,
	UseBarcode varchar(15) null,
	VialQuantity int,
	UnitPrice money,
	PurchaseDate datetime,
	LocationId int foreign key references  TenantLocation(LocationId),
);
go
select * from immunization.dbo.TenantPurchaseInventory;
