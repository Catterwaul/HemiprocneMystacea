import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord)
}

public extension InitializableWithCloudKitRecord {
	static func request(
		database: CKDatabase,
		predicate: NSPredicate = NSPredicate(value: true),
		process: @escaping (
			() throws -> [Self]
		) -> Void
	) {
		database.request(
			predicate: predicate,
			process: process
		)
	}
}

public protocol InitializableWithCloudKitRecordAndReferences {
	associatedtype Reference: InitializableWithCloudKitRecord
	
	static var referenceKey: String {get}
	
	init(
		record: CKRecord,
		references: [Reference]
	)
}

public extension InitializableWithCloudKitRecordAndReferences {
	static func request(
		database: CKDatabase,
		predicate: NSPredicate = NSPredicate(value: true),
		_ process﹙get_requested﹚: @escaping (
			() throws -> Self
		) -> Void,
		_ process﹙verifyCompletion﹚: @escaping (
			() throws -> Void
		) -> Void
	) {
		database.request(
			predicate: predicate,
			process﹙get_requested﹚,
			process﹙verifyCompletion﹚
		)
	}
}
