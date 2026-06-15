@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZWAREHOUSE_G04'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_WAREHOUSE_G04
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_WAREHOUSE_G04
  association [1..1] to ZR_WAREHOUSE_G04 as _BaseEntity on $projection.WAREHOUSEUUID = _BaseEntity.WAREHOUSEUUID
{
  key WarehouseUUID,
  WarehouseID,
  Location,
  Capacity,
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
