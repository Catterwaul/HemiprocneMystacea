import CloudKit

public extension CKDatabase {
	func request<Requested: InitializableWithCloudKitRecord>(
		predicate: NSPredicate = NSPredicate(value: true),
		process: @escaping (
			() throws -> [Requested]
		) -> Void
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
			
			process{records!.map(Requested.init)}
		}
	}
	
	func request<Requested: InitializableWithCloudKitRecordAndReferences>(
		predicate: NSPredicate = NSPredicate(value: true),
		_ process﹙get_requested﹚: @escaping (
			() throws -> Requested
		) -> Void,
		_ process﹙verifyCompletion﹚: @escaping (
			() throws -> Void
		) -> Void
	) {
		let dispatchGroup = DispatchGroup()
		
		func initialize(operation: CKQueryOperation) {
			operation.recordFetchedBlock = {
				requestedRecord in
				
				dispatchGroup.enter()
				CKFetchRecordsOperation(
					references: requestedRecord[Requested.referenceKey] as! [CKReference]
				){	get_records in
					
					do {
						let records = try get_records()
						
						process﹙get_requested﹚{
							Requested(
								record: requestedRecord,
								references: records.map(Requested.Reference.init)
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
