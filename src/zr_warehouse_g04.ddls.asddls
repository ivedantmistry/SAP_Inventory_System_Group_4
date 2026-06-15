@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZWAREHOUSE_G04'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_WAREHOUSE_G04
  as select from ZWAREHOUSE_G04
{
  key warehouse_uuid as WarehouseUUID,
  warehouse_id as WarehouseID,
  location as Location,
  capacity as Capacity,
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
