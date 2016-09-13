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
		_ process﹙get_requested﹚: @escaping ProcessThrowingGet<Self>,
		_ process﹙verifyCompletion﹚: @escaping Process<() throws -> Void>
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
		processSingleRecordError: @escaping Process<Error>,
		_ process﹙get_requesteds﹚: @escaping ProcessThrowingGet<[Self]>
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
					processSingleRecordError(error)
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
