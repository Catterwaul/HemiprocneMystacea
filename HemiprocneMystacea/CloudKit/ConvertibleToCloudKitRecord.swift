import CloudKit

public protocol ConvertibleToCloudKitRecord {
	///- Important: This is a nested type with this signature:
	///  `enum CloudKitRecordKey: String`
	associatedtype CloudKitRecordKey: RawRepresentable
}

public extension CKRecord {
	/// - important: Type name of ConvertibleToCloudKitRecord is the name of its CKRecord
	convenience init<ConvertibleToCloudKitRecord: HM.ConvertibleToCloudKitRecord>(
		_ convertibleToCloudKitRecord: ConvertibleToCloudKitRecord
	)
	where ConvertibleToCloudKitRecord.CloudKitRecordKey.RawValue == String {
		self.init(
			recordType: String(describing: ConvertibleToCloudKitRecord.self)
		)

		Mirror(reflecting: convertibleToCloudKitRecord).children.flatMap{
			label, value in
			
			guard
				let label = label,
				ConvertibleToCloudKitRecord.CloudKitRecordKey.contains(label)
			else {return nil}
			
			return (
				key: label,
				value: {
					switch value {
						case let asset as CKAsset: return asset
						case let date as NSDate: return date
						case let number as NSNumber: return number
						case let string as NSString: return string
						default: return value as? CKRecordValue
					}
				}()
			)
		}.forEach{
			(	key: String,
				value: CKRecordValue?
			) in self[key] = value
		}
	}
}
