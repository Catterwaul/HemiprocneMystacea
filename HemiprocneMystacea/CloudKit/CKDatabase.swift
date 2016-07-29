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
		
		let requestedQueryOperation = CKQueryOperation(
			query: CKQuery(
				recordType: String(Requested.self),
				predicate: predicate
			)
		)…{
			$0.recordFetchedBlock = {
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
			
			$0.queryCompletionBlock = {_ in dispatchGroup.leave()}
		}
		add(requestedQueryOperation)
		
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
