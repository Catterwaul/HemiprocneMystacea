import CloudKit

public extension CKDatabase {
	func request<Requested: InitializableWithCloudKitRecord>(
		predicate: Predicate = Predicate(value: true),
		process: Process< Throwing.Get<[Requested]> >
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
			
			process{
				records!.map(Requested.init)
			}
		}
	}
	
	func request<Requested: InitializableWithCloudKitRecordAndReferences>(
		predicate: Predicate = Predicate(value: true),
		process: Process<[Requested]>
	) {
		let dispatchGroup = DispatchGroup()
		
		var requesteds: [Requested] = []
		
		dispatchGroup.enter()
		
		let requestedQueryOperation = CKQuery(
			recordType: String(Requested.self),
			predicate: predicate
		)…CKQueryOperation.init…{
			$0.recordFetchedBlock = {
				requestedRecord in
				
				dispatchGroup.enter()
				
				let referencesFetchOperation = CKFetchRecordsOperation(
					recordIDs: (
						requestedRecord[Requested.referenceKey] as! [CKReference]
					).map{$0.recordID}
				)…{
					$0.fetchRecordsCompletionBlock = {
						records, error in
						
						requesteds += [
							Requested(
								record: requestedRecord,
								references: records!.values.map(Requested.Reference.init)
							)
						]
						
						dispatchGroup.leave()
					}
				}
				self.add(referencesFetchOperation)
			}
			
			$0.queryCompletionBlock = {
				_ in dispatchGroup.leave()
			}
		}
		add(requestedQueryOperation)
		
		dispatchGroup.notify(
			queue: DispatchQueue(label: "")
		){
			process(requesteds)
		}
	}
}
