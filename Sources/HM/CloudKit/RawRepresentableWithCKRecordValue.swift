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
  init(record: CKRecord, key: some RawRepresentable<CKRecord.FieldKey>) throws {
    self = try Self(rawValue: record[key]).wrappedValue
  }
}
