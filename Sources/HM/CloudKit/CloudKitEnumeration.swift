import CloudKit

/// An enumeration whose cases each correspond with a `CKRecord`.
public protocol CloudKitEnumeration:
  RawRepresentableWithCKRecordValue,
  ConvertibleToCloudKitRecord, InitializableWithCloudKitRecord
where CloudKitRecordKey == CloudKitEnumerationRecordKey { }

public enum CloudKitEnumerationRecordKey: String {
  case rawValue
}

public extension CloudKitEnumeration {
  init(record: CKRecord) throws {
    try self.init(record: record, key: CloudKitRecordKey.rawValue)
  }

  var recordDictionary: RecordDictionary {
    [CloudKitRecordKey.rawValue: rawValue.ckRecordValue]
  }
}
