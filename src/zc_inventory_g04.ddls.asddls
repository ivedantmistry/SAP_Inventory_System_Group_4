@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZINVENTORY_G04'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_INVENTORY_G04
  provider contract transactional_query
  as projection on ZR_INVENTORY_G04
  association [1..1] to ZR_INVENTORY_G04 as _BaseEntity on $projection.InventoryUuid = _BaseEntity.InventoryUuid
{
  key InventoryUuid,
  
      /* Enable Value Help mapping to ZC_PRODUCT_G04 and replace UUID with Name */
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PRODUCT_G04', element: 'ProductUuid' } }]
      @ObjectModel.text.element: ['ProductName']
      ProductUuid,
      
      /* Hidden text field for Product */
      @UI.hidden: true
      _Product.Name as ProductName,

      /* Enable Value Help mapping to ZC_WAREHOUSE_G04 and replace UUID with Location */
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_WAREHOUSE_G04', element: 'WarehouseUuid' } }]
      @ObjectModel.text.element: ['WarehouseLocation']
      WarehouseUuid,
      
      /* Hidden text field for Warehouse */
      @UI.hidden: true
      _Warehouse.Location as WarehouseLocation,

      Quantity,
      UnitOfMeasure,
      LastRestockDate,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      
      /* Expose associations */
      _Product,
      _Warehouse
}
