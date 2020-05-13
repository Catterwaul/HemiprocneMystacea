import CloudKit

extension CKRecord: valueForKeySubscript {
  public typealias Key = FieldKey
}

public extension CKRecord {
  static func makeValue(_ any: Any) -> CKRecordValue? {
    switch any {
    case let convertibleToCKRecordValue as ConvertibleToCKRecordValue:
      return convertibleToCKRecordValue.ckRecordValue
    case let asset as CKAsset:
      return asset
    case let date as NSDate:
      return date
    case let number as NSNumber:
      return number
    default:
      return any as? CKRecordValue
    }
  }
}
