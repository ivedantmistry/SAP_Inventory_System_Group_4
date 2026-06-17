@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZWAREHOUSE_G04'
}
@AccessControl.authorizationCheck: #MANDATORY
@ObjectModel.resultSet.sizeCategory: #XS
define root view entity ZC_WAREHOUSE_G04
  provider contract transactional_query
  as projection on ZR_WAREHOUSE_G04
  association [1..1] to ZR_WAREHOUSE_G04 as _BaseEntity on $projection.WarehouseUUID = _BaseEntity.WarehouseUUID
{
  key WarehouseUUID,
  WarehouseID,
  Location,
  Capacity,
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
