@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Read-only report for shortage'
@Metadata.allowExtensions: true 
define root view entity ZC_INV_SHORTAGE_G04 
  provider contract transactional_query
  as projection on ZR_INVENTORY_G04
{
  key InventoryUuid,
      
      @ObjectModel.text.element: ['ProductName']
      ProductUuid,
      _Product.Name as ProductName,

      @ObjectModel.text.element: ['WarehouseLocation']
      WarehouseUuid,
      _Warehouse.Location as WarehouseLocation,

      Quantity,
      UnitOfMeasure,
      LastRestockDate,

      _Product,
      _Warehouse
}
where Quantity < 50
