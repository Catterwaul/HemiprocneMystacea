import CloudKit

public extension CKDatabase {
	func request<Requested: InitializableWithCloudKitRecord>(
		predicate: Predicate = Predicate(value: true),
		process: Process<
			Throwing.Get<[Requested]>
		>
	){
		perform(
			CKQuery(
				recordType: String(Requested.self),
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
		predicate: Predicate = Predicate(value: true),
		_ process_get_requested: Process<
			Throwing.Get<Requested>
		>,
		_ process_verifyCompletion: Process<() throws -> Void>
	) {
		func initialize(operation: CKQueryOperation) {
			operation.recordFetchedBlock = {
				requestedRecord in
				
				let referencesFetchOperation = CKFetchRecordsOperation(
					references: requestedRecord[Requested.referenceKey] as! [CKReference]
				){	get_records in
					
					do {
						let records = try get_records()
						
						process_get_requested{
							Requested(
								record: requestedRecord,
								references: records.map(Requested.Reference.init)
							)
						}
					}
					catch let error as NSError {
						process_get_requested{throw error}
					}
						
				}
				self.add(referencesFetchOperation)
			}
			
			operation.queryCompletionBlock = {
				cursor, error in
				
				if let error = error {
					process_verifyCompletion{throw error}
				}
				else if let cursor = cursor {
					self.add(
						CKQueryOperation(cursor: cursor)…initialize
					)
				}
				else {
					process_verifyCompletion{}
				}
			}
		}
		
		add(
			CKQueryOperation(
				query: CKQuery(
					recordType: String(Requested.self),
					predicate: predicate
				)
			)…initialize
		)
	}
}
