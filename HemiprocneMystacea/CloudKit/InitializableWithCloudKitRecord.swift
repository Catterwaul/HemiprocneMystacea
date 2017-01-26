import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord) throws
}

public extension InitializableWithCloudKitRecord {
	static func request(
		database: CKDatabase,
		predicate: NSPredicate = NSPredicate(value: true),
		process: @escaping Process<() throws -> [Self]>
	) {
		database.request(
			predicate: predicate,
			process: process
		)
	}
}
