import CloudKit

/// For storing enumeration cases as their raw values, in a `CKRecord`.
public protocol RawRepresentableWithCKRecordValue:
  RawRepresentable, Hashable, ConvertibleToCKRecordValue
where RawValue: ConvertibleToCKRecordValue { }

public extension RawRepresentableWithCKRecordValue {
  var ckRecordValue: CKRecordValue {
    return rawValue.ckRecordValue
  }
}

public extension CKRecord {
  struct RawRepresentableInitializationError<RawValue>: Error {
    public let rawValue: RawValue
  }
}

public extension RawRepresentableWithCKRecordValue {
  init<RecordKey: RawRepresentable>(record: CKRecord, key: RecordKey) throws
  where RecordKey.RawValue == CKRecord.FieldKey {
    let rawValue: RawValue = try record.getValue(key: key)

    guard let initializableWithCloudKitRecord = Self(rawValue: rawValue)
    else { throw CKRecord.RawRepresentableInitializationError(rawValue: rawValue) }

    self = initializableWithCloudKitRecord
  }
}
