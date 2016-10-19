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
				value: value as? CKRecordValue
			)
		}.forEach{
			(	key: String,
				value: CKRecordValue?
			) in self[key] = value
		}
	}
}
