import CloudKit

public extension CKDatabase {
	func request<Requested: InitializableWithCloudKitRecord>(
		predicate: NSPredicate = NSPredicate(value: true),
		process: AsynchronouslyProcess<() throws -> [Requested]>
	){
		perform(
			CKQuery(
				recordType: String(describing: Requested.self),
				predicate: predicate
			),
			inZoneWith: nil
		){	records, error in
			
			if let error = error {
				process{throw error}
				return
			}
			
			process{try records!.map(Requested.init)}
		}
	}
	
	func request<Requested: InitializableWithCloudKitRecordAndReferences>(
		predicate: NSPredicate = NSPredicate(value: true),
		_ process﹙get_requested﹚: AsynchronouslyProcess<() throws -> Requested>,
		_ process﹙verifyCompletion﹚: AsynchronouslyProcess<() throws -> Void>
	) {
		let dispatchGroup = DispatchGroup()
		
		func initialize(operation: CKQueryOperation) {
			operation.recordFetchedBlock = {
				requestedRecord in
				
				guard let references = requestedRecord[Requested.referenceKey] as? [CKReference]
				else {
					process﹙get_requested﹚{
						throw InitializableWithCloudKitRecordAndReferences_Error.emptyReferenceList
					}
					return
				}
				
				dispatchGroup.enter()
				CKFetchRecordsOperation(references: references){
					get_records in
					
					do {
						let references = try get_records().map(Requested.Reference.init)
						
						process﹙get_requested﹚{
							Requested(
								record: requestedRecord,
								references: references
							)
						}
					}
					catch let error as NSError {
						process﹙get_requested﹚{throw error}
					}
					
					dispatchGroup.leave()
				}…self.add
			}
			
			operation.queryCompletionBlock = {
				cursor, error in
				
				if let error = error {
					process﹙verifyCompletion﹚{throw error}
				}
				else if let cursor = cursor {
					self.add(
						CKQueryOperation(cursor: cursor)…initialize
					)
				}
				else {
					dispatchGroup.notify(
						queue: DispatchQueue(label: "")
					){
						process﹙verifyCompletion﹚{}
					}
				}
			}
		}
		
		add(
			CKQueryOperation(
				query: CKQuery(
					recordType: String(describing: Requested.self),
					predicate: predicate
				)
			)…initialize
		)
	}
}
