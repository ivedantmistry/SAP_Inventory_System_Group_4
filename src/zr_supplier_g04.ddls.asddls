@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZSUPPLIER_G04'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_SUPPLIER_G04
  as select from ZSUPPLIER_G04
{
  key supplier_uuid as SupplierUUID,
  supplier_id as SupplierID,
  name as Name,
  contact_email as ContactEmail,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
