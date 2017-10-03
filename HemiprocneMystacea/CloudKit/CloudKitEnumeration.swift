import CloudKit

public protocol CloudKitEnumeration:
  RawRepresentable,
  ConvertibleToCloudKitRecord, InitializableWithCloudKitRecord
where
  Self.RawValue: ConvertibleToCKRecordValue,
  Self.CloudKitRecordKey == CloudKitEnumerationRecordKey
{}

public enum CloudKitEnumerationRecordKey: String {
  case rawValue
}

public struct CloudKitEnumerationInitializationError<RawValue>: Error {
  public let rawValue: RawValue?
}

public extension CloudKitEnumeration {
  init(record: CKRecord) throws {
    guard let rawValue: RawValue = record[CloudKitRecordKey.rawValue]
    else {throw CloudKitEnumerationInitializationError(rawValue: RawValue?.none)}
      
    guard let initializableWithCloudKitRecord = Self(rawValue: rawValue)
    else {throw CloudKitEnumerationInitializationError(rawValue: rawValue)}
    
    self = initializableWithCloudKitRecord
  }

  var recordDictionary: RecordDictionary {
    return [CloudKitRecordKey.rawValue: rawValue.ckRecordValue]
  }
}
