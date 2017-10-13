import CloudKit

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
		_ process: @escaping ProcessGet<Self>,
		_ processVerifyCompletion: @escaping Process<Verify>
	) {
		database.request(
			predicate: predicate,
			process,
			processVerifyCompletion
		)
	}
	
  static func request(
    database: CKDatabase,
    predicate: NSPredicate = NSPredicate(value: true),
    processSingleRecordError: @escaping Process<Error>,
    _ process: @escaping ProcessGet<[Self]>
  ) {
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 1
    
    var requesteds: [Self] = []
    
    request(
      database: database,
      predicate: predicate,
      { getRequested in
        
        do {
          let requested = try getRequested()
          
          operationQueue.addOperation {requesteds += [requested]}
        }
        catch {processSingleRecordError(error)}
      }
    ) {
      verifyCompletion in
      
      do {
        try verifyCompletion()
        
        operationQueue.addOperation { process {requesteds} }
      }
      catch { process {throw error} }
    }
  }
}

enum InitializableWithCloudKitRecordAndReferences_Error: Error {
	case emptyReferenceList
}
