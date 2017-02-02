import CloudKit

public protocol ConvertibleToCloudKitRecord {
	/// - Important: This is a nested type with this signature:
	///  `enum CloudKitRecordKey: String`
	associatedtype CloudKitRecordKey: RawRepresentable
}

//MARK: public
public extension ConvertibleToCloudKitRecord
where CloudKitRecordKey.RawValue == String {
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
				CloudKitRecordKey.contains(label)
			else {return nil}
			
			return (
				key: label,
				value: {
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
