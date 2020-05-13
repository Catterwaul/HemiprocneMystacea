import CloudKit

/// For storing enumeration cases as their raw values, in a `CKRecord`.
public protocol RawRepresentableWithCKRecordValue:
  RawRepresentable, Hashable, ConvertibleToCKRecordValue
where RawValue: ConvertibleToCKRecordValue { }

public extension RawRepresentableWithCKRecordValue {
  var ckRecordValue: CKRecordValue { rawValue.ckRecordValue }
}

public extension RawRepresentableWithCKRecordValue {
  init<RecordKey: RawRepresentable>(record: CKRecord, key: RecordKey) throws
  where RecordKey.RawValue == CKRecord.FieldKey {
    let rawValue: RawValue = try record.value(for: key)

    guard let initializableWithCloudKitRecord = Self(rawValue: rawValue)
    else { throw RawRepresentableError<Self>.invalidRawValue(rawValue) }

    self = initializableWithCloudKitRecord
  }
}
