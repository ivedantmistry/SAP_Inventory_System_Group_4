@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Inventory Item Management'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZINVENTORY_G04'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_INVENTORY_G04
  provider contract transactional_query
  as projection on ZR_INVENTORY_G04
{
  key InventoryUuid,
  
      /* Enable Value Help mapping to ZC_PRODUCT_G04 and hide UUID completely */
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PRODUCT_G04', element: 'ProductUUID' } }]
      @ObjectModel.text.element: ['ProductName']
      @UI.textArrangement: #TEXT_ONLY
      ProductUuid,
      
      /* Hidden text field for Product */
      @UI.hidden: true
      _Product.Name as ProductName,

      /* Enable Value Help mapping to ZC_WAREHOUSE_G04 and hide UUID completely */
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_WAREHOUSE_G04', element: 'WarehouseUUID' } }]
      @ObjectModel.text.element: ['WarehouseLocation']
      @UI.textArrangement: #TEXT_ONLY
      WarehouseUuid,
      
      /* Hidden text field for Warehouse */
      @UI.hidden: true
      _Warehouse.Location as WarehouseLocation,

      Quantity,
      
      /* Attach Standard SAP Unit of Measure Value Help */
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_UnitOfMeasure', element: 'UnitOfMeasure' } }]
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
