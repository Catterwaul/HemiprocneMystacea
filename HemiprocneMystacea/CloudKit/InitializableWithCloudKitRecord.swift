import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord) throws
}

public extension InitializableWithCloudKitRecord {
	static func request(
		database: CKDatabase,
		predicate: NSPredicate = NSPredicate(value: true),
		process: AsynchronouslyProcess<() throws -> [Self]>
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
		_ process﹙get_requested﹚: AsynchronouslyProcess<() throws -> Self>,
		_ process﹙verifyCompletion﹚: AsynchronouslyProcess<() throws -> Void>
	) {
		database.request(
			predicate: predicate,
			process﹙get_requested﹚,
			process﹙verifyCompletion﹚
		)
	}
}

enum InitializableWithCloudKitRecordAndReferences_Error: Error {
	case emptyReferenceList
}
