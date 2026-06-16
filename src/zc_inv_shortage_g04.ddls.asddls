@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inventory Shortage Report'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true

/* 1. Configure the header info for the Object Page */
@UI.headerInfo: {
  typeName: 'Shortage Item',
  typeNamePlural: 'Shortage Items',
  title: { type: #STANDARD, value: 'ProductUuid' }
}

define view entity ZC_INV_SHORTAGE_G04
  as select from ZR_INVENTORY_G04
  
  /* Define associations to fetch text data from Product and Warehouse */
  association [1..1] to ZR_PRODUCT_G04   as _Product   on $projection.ProductUUID = _Product.ProductUUID
  association [1..1] to ZR_WAREHOUSE_G04 as _Warehouse on $projection.WarehouseUUID = _Warehouse.WarehouseUUID

{
      /* 2. Create a Facet (Container) to hold the details on the Object Page */
      @UI.facet: [ {
        id:              'ItemDetails',
        purpose:         #STANDARD,
        type:            #IDENTIFICATION_REFERENCE,
        label:           'Item Details',
        position:        10
      } ]

      @UI.hidden: true 
  key InventoryUUID,

      @UI.lineItem: [ { position: 10, label: 'Product' } ]
      @UI.identification: [ { position: 10, label: 'Product' } ] /* Show in Object Page */
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['ProductName'] 
      ProductUUID,

      @UI.hidden: true 
      @Semantics.text: true
      _Product.Name as ProductName,

      @UI.lineItem: [ { position: 20, label: 'Warehouse Location' } ]
      @UI.identification: [ { position: 20, label: 'Warehouse Location' } ] /* Show in Object Page */
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['WarehouseLocation'] 
      WarehouseUUID,

      @UI.hidden: true
      @Semantics.text: true
      _Warehouse.Location as WarehouseLocation,

      @UI.lineItem: [ { position: 30, label: 'Current Quantity' } ]
      @UI.identification: [ { position: 30, label: 'Current Quantity' } ] /* Show in Object Page */
      Quantity,

      @UI.identification: [ { position: 35, label: 'Unit' } ] /* Show in Object Page */
      UnitOfMeasure,
      
      @UI.lineItem: [ { position: 40, label: 'Last Restock Date' } ]
      @UI.identification: [ { position: 40, label: 'Last Restock Date' } ] /* Show in Object Page */
      LastRestockDate,
      
      /* Expose associations to the projection layer */
      _Product,
      _Warehouse
}
/* Filter for items with stock below 50 */
where Quantity < 50
