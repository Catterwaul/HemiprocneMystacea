import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord) throws
}
