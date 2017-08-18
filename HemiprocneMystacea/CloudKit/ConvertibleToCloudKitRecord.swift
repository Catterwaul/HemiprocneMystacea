import CloudKit

public protocol ConvertibleToCloudKitRecord {
	/// - Important: This is a nested type with this signature:
	///  `enum CloudKitRecordKey: String`
	associatedtype CloudKitRecordKey: Hashable, RawRepresentable
  where CloudKitRecordKey.RawValue == String
	
	/// Overrides for record values,
	/// probably because they don't implement `CKRecordValue`.
	var recordDictionaryOverrides: [CloudKitRecordKey: CKRecordValue] {get}
}

//MARK: public
public extension ConvertibleToCloudKitRecord {
	var recordDictionaryOverrides: [CloudKitRecordKey: CKRecordValue] {
		return [:]
	}
	
	func synchronize(record: CKRecord) {
		for (key, value) in recordDictionaryPairs {
			record[key] = value
		}
	}
}

//MARK: private
private extension ConvertibleToCloudKitRecord {
  var recordDictionaryPairs: [(key: String, value: CKRecordValue?)] {
    return Mirror(reflecting: self).children.flatMap{
      child in
      
      guard
        let label = child.label,
        let key = CloudKitRecordKey(rawValue: label)
      else {return nil}
      
      return (
        key: label,
        value:
          recordDictionaryOverrides.keys.contains(key)
          ? recordDictionaryOverrides[key]
          : {
            switch child.value {
            case let asset as CKAsset:
              return asset
              
            case let date as NSDate:
              return date
              
            case let number as NSNumber:
              return number
              
            case let string as NSString:
              return string
              
            default: return child.value as? CKRecordValue
            }
          }()
			)
		}
	}
}

//MARK:
public extension CKRecord {
	/// - Important: Type name of ConvertibleToCloudKitRecord is the name of its CKRecord
	convenience init<ConvertibleToCloudKitRecord: HM.ConvertibleToCloudKitRecord>(
		_ convertibleToCloudKitRecord: ConvertibleToCloudKitRecord
	) {
		self.init(
			recordType: String(describing: ConvertibleToCloudKitRecord.self)
		)
		convertibleToCloudKitRecord.synchronize(record: self)
	}
}
