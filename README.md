# im_yuh_nuh_zey_shuh_n

### SQL Query use case
* Shared_Create_Database           - Create table Immunziation
* SharedTable **CDC_Vaccine_List** - Pull data from https://www2a.cdc.gov/vaccines/iis/iisstandards/downloads/NDC/get_all_ndc_display.txt and keep it updated 

  
* SharedTable **VaccineGroup**     - All Vaccine Groups like Hep B, MMR, Flu etc.
* SharedTable **VaccineBrand**     - Manufacturer specific. Hep B (Engerix-B, Twinrix), Flu ( Fluzone, Fluarix). Each health center has its own inventory but master list in CDC table
* SharedTable **VaccineProgram**   - Emum for vaccine program and funding source in one. May have to separate

  #### Tenant Specific data
  * TenantTable **Tenant**           - Different health centers using the app
  * TenantTable **Tenantocation**    - Locations / departments if tenents using the app. Each tenant can one or more location. building A, Building B, Pediatrics department etc. Centricity EMR has facility and it is subdivided into LOC (location of care). Example Faclity-A has LOC-A1, LOC-A2 etc. Inventory could be based on Facility or LOC. Different health center might do it differently. Athena EMR has departments. Multiple department might share same address. Inventory could be based on department or shared address.
  * TenantTable **TenantPurchaseInventory** - initial inventory of purchased vaccines. columns from chat gpt.
  * TenantTable **VaccineLotNumber** - Lot available in the cliniuca. Example. Hep B > Engerix-B (lot A ⇒ Exp Date mm/dd/yy, lot B ⇒ Exp Date mm/dd/yy), FLU > Fluzone (lot Z ⇒ Exp Date mm/dd/yy, lot Y ⇒ Exp Date mm/dd/yy)
  * TenantTable **VaccineGiven**     - Data from EMR. Centricity require stored procedure to pull data. Athena sends data via API
  
* View ImmunizationDetails         - Simple view to show how tables relate

  #### Immunization.Centricity
  * SourceTable ContentList              - Table in Centricity to store immunization setup like vaccine group, brand, lot number etc.
  * SourceTable Immunization             - Table in Centricity to store immunization administered
  * IntermediateTable ImmunizationSetup  - Intermediate table to hold data flattened immunization data structure. From nodes and namespace to Flat data structure
  * IntermediateTable ImmunizationGiven  - Optional. Stored procedure for different use case. 
    
  * StoredProcedure VaccineGroup         - Pull vaccine group from ImmunizationSetup. Do we need this if shared table VaccineGroup is going to be storing all the vaccines.
  * StoredProcedure VaccineBrand         - Pull vaccine group from ImmunizationSetup. Do we need this if shared table VaccineBrand is going to be storing all the brand from CDC website.
  * StoredProcedure VaccineLotNumber     - Pull latest lot numbers from ImmunizationSetup. When a given vaccine lot empty, it is deleted in EMR. Need to save it here as inactive lot.
  * StoredProcedure VaccineGiven         - Pull from ImmunizationGiven. Query can be updated to pull data directly from EMR tables.
