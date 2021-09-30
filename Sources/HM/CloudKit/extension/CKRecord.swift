import CloudKit

extension CKRecord: DictionaryLike { }

public extension CKRecord {
  typealias AccessError = KeyValuePairs<String, CKRecordValue>.AccessError
  
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
