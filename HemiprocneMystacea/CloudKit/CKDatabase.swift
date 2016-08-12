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
		process: Process<
			Throwing.Get<[Requested]>
		>
	) {
		let dispatchGroup = DispatchGroup()
		
		var
		requesteds: [Requested] = [],
		errors: Set<NSError> = []
		
		dispatchGroup.enter()
		
		func initialize(operation: CKQueryOperation) {
			operation.recordFetchedBlock = {
				requestedRecord in
				
				dispatchGroup.enter()
				
				let referencesFetchOperation = CKFetchRecordsOperation(
					references: requestedRecord[Requested.referenceKey] as! [CKReference]
				){	get_records in
					
					do {
						let records = try get_records()
						
						requesteds += [
							Requested(
								record: requestedRecord,
								references: records.map(Requested.Reference.init)
							)
						]
					}
					catch let error as NSError {
						errors.insert(error)
					}
						
					dispatchGroup.leave()
				}
				self.add(referencesFetchOperation)
			}
			
			operation.queryCompletionBlock = {
				cursor, error in
				
				if let error = error {
					errors.insert(error)
					dispatchGroup.leave()
				}
				else if let cursor = cursor {
					self.add(
						CKQueryOperation(cursor: cursor)…initialize
					)
				}
				else {
					dispatchGroup.leave()
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
		
		dispatchGroup.notify(
			queue: DispatchQueue(label: "")
		){
			guard errors.isEmpty
			else {
				process{throw Errors(errors)}
				return
			}
			
			process{requesteds}
		}
	}
}
