@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZPRODUCT_G04'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_PRODUCT_G04
  provider contract transactional_query
  as projection on ZR_PRODUCT_G04
  association [1..1] to ZR_PRODUCT_G04 as _BaseEntity on $projection.ProductUUID = _BaseEntity.ProductUUID
{
  @ObjectModel.text.element: ['Name']  
  key ProductUUID,
  ProductID,
  @Semantics.text: true
  Name,
  CategoryUUID,
  SupplierUUID,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  Price,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
