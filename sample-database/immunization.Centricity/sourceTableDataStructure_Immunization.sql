/*==============================================================*/
/* Table: Immunization */
/*==============================================================*/
create table dbo.Immunization (
ImmunizationId numeric(19, 0) not null,
ImmunizationGroupId numeric(19, 0) not null,
Inactive varchar(1) not null,
PID numeric(19, 0) not null,
SDID numeric(19, 0) not null,
VaccineGroupName varchar(50) null,
VaccineName varchar(255) null,
MedicalDisplayName varchar(255) null,
Series smallint null,
WasGiven varchar(1) not null constraint DF_Immunization_WasGiven default 'Y',
ReasonNotGiven varchar(255) null,
Historical varchar(1) not null constraint DF_Immunization_Historical default 'N',
HistoricalSource varchar(255) null,
VFCEligibility varchar(5) not null,
DDID numeric(19, 0) null,
DNID numeric(19, 0) null,
GPI varchar(14) null,
KDC numeric(19, 0) null,
NDC varchar(11) null,
CVXCode varchar(10) null,
AdministeredDose float null,
AdministeredDoseUnits varchar(20) null,
Route varchar(30) null,
RouteCode varchar(20) null,
Site varchar(30) null,
SiteCode varchar(20) null,
Manufacturer varchar(50) null,
ManufacturerCode varchar(20) null,
LotNumber varchar(30) null,
ExpirationDate datetime2(7) null,
VISPublishedDate datetime2(7) null,
AdministeredByPVId numeric(19, 0) null,
AdministeredDate datetime2(7) null,
AdministeredDateType varchar(1) null,
AdministeredComments varchar(400) null,
AdvReactionDateTime datetime2(7) null,
AdvReactionDateTimeType varchar(1) null,
AdvReactionComments varchar(400) null,
AdvReactionCmtByPVId numeric(19, 0) null,
Signed varchar(1) not null constraint DF_Immunization_Signed default 'N',
SignedByPVId numeric(19, 0) null,
SignedDate datetime2(7) null,
FiledInError varchar(1) not null constraint DF_Immunization_FiledInError default 'N',
ReasonRemoved varchar(25) null,
StopDate datetime2(7) null,
DB_Create_Date datetime2(7) not null constraint DF_Immunization_DB_Create_Date default getdate(),
CreatedBy varchar(30) not null,
DB_Updated_Date datetime2(7) not null constraint DF_Immunization_DB_Update_Date default getdate(),
LastModifiedBy varchar(30) not null,
ReasonNotGivenMedical varchar(255) null,
ReasonNotGivenMedicalDetail varchar(50) null,
AllergyGroupId numeric(19, 0) null,
AdministeredDoseWasted varchar(50) null,
VISGiven char(1) null,
VISGivenDate datetime2(7) null,
FundingSource varchar(100) null,
FundingSourceDescription varchar(450) null,
constraint PK_Immunization primary key (ImmunizationId),
constraint CHK_IMMUN_VISGIVEN check ([VISGIVEN]='N' OR [VISGIVEN]='Y')

)
go

/*==============================================================*/
/* Index: Immunization_ImmunizationGroupId_ix */
/*==============================================================*/




create nonclustered index Immunization_ImmunizationGroupId_ix on dbo.Immunization (ImmunizationGroupId ASC)
go

/*==============================================================*/
/* Index: Immunization_Pid_ix */
/*==============================================================*/




create nonclustered index Immunization_Pid_ix on dbo.Immunization (PID ASC)
go

/*==============================================================*/
/* Index: Immunization_Sdid_ix */
/*==============================================================*/




create nonclustered index Immunization_Sdid_ix on dbo.Immunization (SDID ASC)
go

alter table dbo.Immunization
add constraint FK_Immunization_DOCUMENT foreign key (SDID)
references dbo.DOCUMENT (SDID)
go

alter table dbo.Immunization
add constraint FK_Immunization_PatientProfile foreign key (PID)
references dbo.PatientProfile (PId)
go
