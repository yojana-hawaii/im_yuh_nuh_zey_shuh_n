# im_yuh_nuh_zey_shuh_n

### SQL Query use case
* Shared_Create_Database           - Create table Immunziation
* SharedTable **CDC_Vaccine_List** - Pull data from https://www2a.cdc.gov/vaccines/iis/iisstandards/downloads/NDC/get_all_ndc_display.txt and keep it updated 
* SharedTable **Tenant**           - Different health centers using the app
  
* SharedTable **VaccineGroup**     - All Vaccine Groups like Hep B, MMR, Flu etc.
* SharedTable **VaccineBrand**     - Manufacturer specific. Hep B (Engerix-B, Twinrix), Flu ( Fluzone, Fluarix). Each health center has its own inventory but master list in CDC table
  
* TenantTable **VaccineLotNumber** - Lot available in the cliniuca. Example. Hep B > Engerix-B (lot A ⇒ Exp Date mm/dd/yy, lot B ⇒ Exp Date mm/dd/yy), FLU > Fluzone (lot Z ⇒ Exp Date mm/dd/yy, lot Y ⇒ Exp Date mm/dd/yy)
* TenantTable **VaccineGiven**     - Data from EMR. Centricity require stored procedure to pull data. Athena sends data via API
  
* View ImmunizationDetails         - Simple view to show how tables relate

  #### Immunization.Centricity
  * SourceTable ContentList              - 
  * SourceTable Immunization             -
  * IntermediateTable ImmunizationSetip  -
  * IntermediateTable ImmunizationGiven  -
  * StoredProcedure VaccineGroup         -
  * StoredProcedure VaccineBrand         -
  * StoredProcedure VaccineLotNumber     -
  * StoredProcedure VaccineGiven         -
