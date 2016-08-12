import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord)
}

public extension InitializableWithCloudKitRecord {
	static func request(
		database: CKDatabase,
		predicate: Predicate = Predicate(value: true),
		process: Process<
			Throwing.Get<[Self]>
		>
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
		predicate: Predicate = Predicate(value: true),
		_ process_get_requested: Process<
			Throwing.Get<Self>
		>,
		_ process_verifyCompletion: Process<() throws -> Void>
	) {
		database.request(
			predicate: predicate,
			process_get_requested,
			process_verifyCompletion
		)
	}
}
