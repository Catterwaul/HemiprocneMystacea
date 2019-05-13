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
