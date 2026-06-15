@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZINVENTORY_G04'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_INVENTORY_G04
  as select from ZINVENTORY_G04
{
  key inventory_uuid as InventoryUUID,
  product_uuid as ProductUUID,
  warehouse_uuid as WarehouseUUID,
  quantity as Quantity,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_UnitOfMeasureStdVH', 
    entity.element: 'UnitOfMeasure', 
    useForValidation: true
  } ]
  unit_of_measure as UnitOfMeasure,
  last_restock_date as LastRestockDate,
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
