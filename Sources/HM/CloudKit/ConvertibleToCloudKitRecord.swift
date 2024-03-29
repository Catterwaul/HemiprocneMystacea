import CloudKit

public protocol ConvertibleToCloudKitRecord {
  typealias RecordDictionary = [CloudKitRecordKey: CKRecordValue]
  
	/// - Important: This is a nested type with this signature:
	///  `enum CloudKitRecordKey: String`
	associatedtype CloudKitRecordKey: Hashable, RawRepresentable
  where CloudKitRecordKey.RawValue == CKRecord.FieldKey
	
	/// Overrides for record values,
	/// probably because they don't implement `CKRecordValue`.
	var recordDictionaryOverrides: RecordDictionary { get }
  
  var recordDictionary: RecordDictionary { get }
}

// MARK: - public
public extension ConvertibleToCloudKitRecord {
	var recordDictionaryOverrides: RecordDictionary { [:] }

  var recordDictionary: RecordDictionary {
    let keyValuePairs = Mirror(reflecting: self).children.compactMap {
      child -> (key: CloudKitRecordKey, value: CKRecordValue)? in

      guard
        let key = child.label.flatMap(CloudKitRecordKey.init),
        !recordDictionaryOverrides.keys.contains(key),
        let value = CKRecord.makeValue(child.value)
      else { return nil }

      return (key, value)
    }

    return
      Dictionary(uniqueKeysWithValues: keyValuePairs)
      .merging(recordDictionaryOverrides) { $1 }
	}
}

// MARK: -
public extension CKRecord {
	/// - Important: Type name of ConvertibleToCloudKitRecord is the name of its CKRecord
	convenience init(_ convertibleToCloudKitRecord: some ConvertibleToCloudKitRecord) {
		self.init(recordType: "\(type(of: convertibleToCloudKitRecord))")
		synchronize(convertibleToCloudKitRecord)
	}
  
  func synchronize(_ convertibleToCloudKitRecord: some ConvertibleToCloudKitRecord) {
    for (key, value) in convertibleToCloudKitRecord.recordDictionary {
      self[key.rawValue] = value
    }
  }
}
