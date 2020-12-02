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

// MARK: public
public extension ConvertibleToCloudKitRecord {
	var recordDictionaryOverrides: RecordDictionary { [:] }
}

// MARK: private
public extension ConvertibleToCloudKitRecord {
  var recordDictionary: RecordDictionary {
    let keyValuePairs = Mirror(reflecting: self).children.compactMap {
      child -> (key: CloudKitRecordKey, value: CKRecordValue)? in

      guard
        let label = child.label,
        let key = CloudKitRecordKey(rawValue: label),
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
	convenience init<ConvertibleToCloudKitRecord: HM.ConvertibleToCloudKitRecord>(
		_ convertibleToCloudKitRecord: ConvertibleToCloudKitRecord
	) {
		self.init(recordType: "\(ConvertibleToCloudKitRecord.self)")
		synchronize(convertibleToCloudKitRecord)
	}
  
  func synchronize<ConvertibleToCloudKitRecord: HM.ConvertibleToCloudKitRecord>(
    _ convertibleToCloudKitRecord: ConvertibleToCloudKitRecord
  ) {
    for (key, value) in convertibleToCloudKitRecord.recordDictionary {
      self[key.rawValue] = value
    }
  }
}
