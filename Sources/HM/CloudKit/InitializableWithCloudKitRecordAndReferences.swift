import typealias Combine.Future
import CloudKit

public protocol InitializableWithCloudKitRecordAndReferences {
	associatedtype Reference: InitializableWithCloudKitRecord
	
	static var referenceKey: String { get }
	
	init(
		record: CKRecord,
		references: [Reference]
	) throws
}

public extension InitializableWithCloudKitRecordAndReferences {
	static func request(
		database: CKDatabase,
		predicate: NSPredicate = .init(value: true),
		_ process: @escaping ProcessGet<Self>,
    _ processVerifyCompletion: @escaping Future<Void, Error>.Promise
	) {
		database.request(
			predicate: predicate,
			process,
			processVerifyCompletion
		)
	}
	
  static func request(
    database: CKDatabase,
    predicate: NSPredicate = .init(value: true),
    processSingleRecordError: @escaping (Error) -> Void,
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
          
          operationQueue.addOperation { requesteds += [requested] }
        } catch {
          processSingleRecordError(error)
        }
      }
    ) { completionResult in
      switch completionResult {
      case .success:
        operationQueue.addOperation { process { requesteds } }
      case .failure(let error):
        process { throw error }
      }
    }
  }
}

enum InitializableWithCloudKitRecordAndReferencesExtensions {
  enum Error: Swift.Error {
    case emptyReferenceList
  }
}
