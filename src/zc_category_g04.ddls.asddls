@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCATEGORY_G04'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CATEGORY_G04
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CATEGORY_G04
  association [1..1] to ZR_CATEGORY_G04 as _BaseEntity on $projection.CATEGORYUUID = _BaseEntity.CATEGORYUUID
{
  key CategoryUUID,
  CategoryID,
  Name,
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
