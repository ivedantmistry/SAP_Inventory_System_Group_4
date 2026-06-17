@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZINVENTORY_G04'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_INVENTORY_G04
  as select from zinventory_g04
  /* Define associations for Text and Value Help */
  association [1..1] to ZR_PRODUCT_G04   as _Product   on $projection.ProductUuid = _Product.ProductUUID
  association [1..1] to ZR_WAREHOUSE_G04 as _Warehouse on $projection.WarehouseUuid = _Warehouse.WarehouseUUID
{
  key inventory_uuid        as InventoryUuid,
      product_uuid          as ProductUuid,
      warehouse_uuid        as WarehouseUuid,
      quantity              as Quantity,
      unit_of_measure       as UnitOfMeasure,
      last_restock_date     as LastRestockDate,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      /* Expose associations */
      _Product,
      _Warehouse
}
