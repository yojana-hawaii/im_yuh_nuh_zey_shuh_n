
/*
This table store the lookup values that need to be populated on the CCC forms for Medadministration, Immunization, ClinicalVisitSummary, Cancer case. ContentList will be shared by Medadministration, Immunization, ClinicalVisitSummary, Cancer case for storing the lookup values.
*/


/*==============================================================*/
/* Table: ContentList */
/*==============================================================*/
create table dbo.ContentList (
ContentListID numeric(19, 0) not null,
Namespace varchar(255) not null,
NodeName varchar(20) null,
DisplayName varchar(400) null,
SourceName varchar(400) null,
Code varchar(20) null,
CodeType varchar(10) null,
ContentGroup smallint null,
ListOrder smallint null,
ContentDefault smallint null,
Owner varchar(1) not null constraint DF_ContentList_Owner default 'F',
Created datetime2(7) not null constraint DF_ContentList_Created default getdate(),
CreatedBy varchar(30) not null,
LastModified datetime2(7) not null constraint DF_ContentList_LastModified default getdate(),
LastModifiedBy varchar(30) not null,
constraint PK_ContentList primary key (ContentListID)

)
go

/*==============================================================*/
/* Index: ContentList_NameSpace_ix */
/*==============================================================*/




create nonclustered index ContentList_NameSpace_ix on dbo.ContentList (Namespace ASC)
go

/*==============================================================*/
/* Index: cpns1_ContentList_DisplayName */
/*==============================================================*/




create nonclustered index cpns1_ContentList_DisplayName on dbo.ContentList (DisplayName ASC)
go

/*==============================================================*/
/* Index: contentlist_codetype_idx */
/*==============================================================*/




create nonclustered index contentlist_codetype_idx on dbo.ContentList (CodeType ASC)
go