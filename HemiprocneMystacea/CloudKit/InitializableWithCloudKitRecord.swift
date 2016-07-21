import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord)
}

public extension InitializableWithCloudKitRecord {
	static func request(
		database: CKDatabase,
		predicate: Predicate = Predicate(value: true),
		process: Process< Throwing.Get<[Self]> >
	) {
		database.request(
			predicate: predicate,
			process: process
		)
	}
}
