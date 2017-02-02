import CloudKit

public protocol ConvertibleToCloudKitRecord {
	/// - Important: This is a nested type with this signature:
	///  `enum CloudKitRecordKey: String`
	associatedtype CloudKitRecordKey: Hashable, RawRepresentable
	
	/// Overrides for record values,
	/// probably because they don't implement `CKRecordValue`.
	var recordDictionaryOverrides: [CloudKitRecordKey: CKRecordValue] {get}
}

//MARK: public
public extension ConvertibleToCloudKitRecord
where CloudKitRecordKey.RawValue == String {
	var recordDictionaryOverrides: [CloudKitRecordKey: CKRecordValue] {
		return [:]
	}
	
	func synchronize(record: CKRecord) {
		for (key, value) in recordDictionaryPairs {
			record[key] = value
		}
	}
}

//MARK: fileprivate
private extension ConvertibleToCloudKitRecord
where CloudKitRecordKey.RawValue == String {
	var recordDictionaryPairs: [(key: String, value: CKRecordValue?)] {
		return Mirror(reflecting: self).children.flatMap{
			label, value in
			
			guard
				let label = label,
				let key = CloudKitRecordKey(rawValue: label)
			else {return nil}
			
			return (
				key: label,
				value:
					recordDictionaryOverrides.keys.contains(key)
					? recordDictionaryOverrides[key]
					: {
						switch value {
						case let asset as CKAsset:
							return asset
							
						case let date as NSDate:
							return date
							
						case let number as NSNumber:
							return number
							
						case let string as NSString:
							return string
							
						default: return value as? CKRecordValue
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
	)
	where ConvertibleToCloudKitRecord.CloudKitRecordKey.RawValue == String {
		self.init(
			recordType: String(describing: ConvertibleToCloudKitRecord.self)
		)
		convertibleToCloudKitRecord.synchronize(record: self)
	}
}
