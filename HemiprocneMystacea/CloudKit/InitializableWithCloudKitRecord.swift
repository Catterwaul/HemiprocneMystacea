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
	) throws
}

public extension InitializableWithCloudKitRecordAndReferences {
	static func request(
		database: CKDatabase,
		predicate: NSPredicate = NSPredicate(value: true),
		_ process﹙get_requested﹚: AsynchronouslyProcessThrowingGet<Self>,
		_ process﹙verifyCompletion﹚: AsynchronouslyProcess<() throws -> Void>
	) {
		database.request(
			predicate: predicate,
			process﹙get_requested﹚,
			process﹙verifyCompletion﹚
		)
	}
	
	static func request(
		database: CKDatabase,
		predicate: NSPredicate = NSPredicate(value: true),
		_ process﹙get_requesteds﹚: AsynchronouslyProcessThrowingGet<[Self]>
	) {
		let operationQueue = OperationQueue()…{$0.maxConcurrentOperationCount = 1}
		
		var requesteds: [Self] = []
		
		request(
			database: database,
			predicate: predicate,
			{	get_requested in
		
				do {
					let requested = try get_requested()
					
					operationQueue.addOperation{requesteds += [requested]}
				}
				catch {
					process﹙get_requesteds﹚{throw error}
				}
			}
		){	verifyCompletion in
			
			do {
				try verifyCompletion()
				
				operationQueue.addOperation{
					process﹙get_requesteds﹚{requesteds}
				}
			}
			catch {
				process﹙get_requesteds﹚{throw error}
			}
		}
	}
}

enum InitializableWithCloudKitRecordAndReferences_Error: Error {
	case emptyReferenceList
}
