import CloudKit

public extension CKDatabase {
	func request<Requested: InitializableWithCloudKitRecord>(
		predicate: NSPredicate = NSPredicate(value: true),
		process: @escaping Process<() throws -> [Requested]>
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
		_ processGetRequested: @escaping ProcessThrowingGet<Requested>,
		_ processVerifyCompletion: @escaping Process<Verify>
	) {
		let dispatchGroup = DispatchGroup()
		
		func initialize(_ operation: CKQueryOperation) {
			operation.recordFetchedBlock = {
				requestedRecord in
				
				guard let references = requestedRecord[Requested.referenceKey] as? [CKReference]
				else {
					processGetRequested{
						throw InitializableWithCloudKitRecordAndReferences_Error.emptyReferenceList
					}
					return
				}
				
				dispatchGroup.enter()
				
				let operation = CKFetchRecordsOperation(references: references){
					get_records in
					
					do {
						let references = try get_records()
							.map(Requested.Reference.init)
						
						processGetRequested{
							try Requested(
								record: requestedRecord,
								references: references
							)
						}
					}
					catch {
						processGetRequested{throw error}
					}
					
					dispatchGroup.leave()
				}
				self.add(operation)
			}
			
			operation.queryCompletionBlock = {
				cursor, error in
				
				if let error = error {
					processVerifyCompletion{throw error}
				}
				else if let cursor = cursor {
					let operation = CKQueryOperation(cursor: cursor)
					initialize(operation)
					self.add(operation)
				}
				else {
					dispatchGroup.notify(
						queue: DispatchQueue(label: "")
					){
						processVerifyCompletion{}
					}
				}
			}
		}
		
		let operation = CKQueryOperation(
			query: CKQuery(
				recordType: String(describing: Requested.self),
				predicate: predicate
			)
		)
		initialize(operation)
		add(operation)
	}
}
