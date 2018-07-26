import CloudKit

public protocol ConvertibleToCKRecordValue {
  var ckRecordValue: CKRecordValue { get }
}

extension String: ConvertibleToCKRecordValue {
  public var ckRecordValue: CKRecordValue {
    return self as NSString
  }
}

extension Int: ConvertibleToCKRecordValue {
  public var ckRecordValue: CKRecordValue {
    return self as NSNumber
  }
}

extension Double: ConvertibleToCKRecordValue {
  public var ckRecordValue: CKRecordValue {
    return self as NSNumber
  }
}

public func makeCKRecordValue(_ any: Any) -> CKRecordValue? {
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
