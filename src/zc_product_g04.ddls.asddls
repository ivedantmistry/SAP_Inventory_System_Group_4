@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZPRODUCT_G04'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PRODUCT_G04
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_PRODUCT_G04
  association [1..1] to ZR_PRODUCT_G04 as _BaseEntity on $projection.PRODUCTUUID = _BaseEntity.PRODUCTUUID
{
  key ProductUUID,
  ProductID,
  Name,
  CategoryUUID,
  SupplierUUID,
  @Semantics: {
    Amount.Currencycode: 'Currency'
  }
  Price,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  Currency,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
