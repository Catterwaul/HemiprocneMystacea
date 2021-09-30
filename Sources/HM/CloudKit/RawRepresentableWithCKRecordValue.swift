import CloudKit

/// For storing enumeration cases as their raw values, in a `CKRecord`.
public protocol RawRepresentableWithCKRecordValue:
  RawRepresentable, Hashable, ConvertibleToCKRecordValue
where RawValue: ConvertibleToCKRecordValue { }

public extension RawRepresentableWithCKRecordValue {
  var ckRecordValue: CKRecordValue { rawValue.ckRecordValue }
}

public extension RawRepresentableWithCKRecordValue {
  /// - Throws: `UnwrapError`s
  init<RecordKey: RawRepresentable>(record: CKRecord, key: RecordKey) throws
  where RecordKey.RawValue == CKRecord.FieldKey {
    self = try Self(rawValue: record[key]).unwrapped
  }
}
