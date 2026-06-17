@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPRODUCT_G04'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PRODUCT_G04
  as select from zproduct_g04
{
  key product_uuid as ProductUUID,
  product_id as ProductID,
  name as Name,
  category_uuid as CategoryUUID,
  supplier_uuid as SupplierUUID,
  @Semantics.amount.currencyCode: 'Currency'
  price as Price,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
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
