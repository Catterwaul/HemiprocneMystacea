import CloudKit

public extension CKDatabase {
	/// Request `CKRecord`s that correspond to a Swift type.
	///
	/// - Parameters:
	///   - recordType: Its name has to be the same in your code, and in CloudKit.
	///   - predicate: for the `CKQuery`
	///   - process: processes a *throwing get [CKRecord]*
	func request<Requested>(
		recordType: Requested.Type,
		predicate: NSPredicate = NSPredicate(value: true),
		process: @escaping Process<() throws -> [CKRecord]>
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
			
			process{records!}
		}
	}
	
	/// Request `CKRecord`s that correspond to a Swift type,
	/// and return the result of initializing those types
	/// with the records.
	///
	/// - Parameters:
	///   - predicate: for the `CKQuery`
	///   - process: processes a *throwing get [Requested]*
	func request<Requested: InitializableWithCloudKitRecord>(
		predicate: NSPredicate = NSPredicate(value: true),
		process: @escaping Process<() throws -> [Requested]>
	){
		request(
			recordType: Requested.self,
			predicate: predicate
		){	getRecords in process{
				try getRecords()
				.map(Requested.init)
			}
		}
	}
	
	/// Request `CKRecord`s that correspond to a Swift type,
	/// and implement `InitializableWithCloudKitRecordAndReferences`
	/// because they use forward references.
	///
	/// Processing the result of initializing instances of those types
	/// happens individually. 
	/// Then processing verification of completion of the operation happens.
	///
	/// - Parameters:
	///   - predicate: for the `CKQuery`
	///   - processGetRequested: processes a *throwing get Requested*
	///   - processVerifyCompletion: processes a `Verify` upon completion of the request
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
					getRecords in
					
					do {
						let references =
							try getRecords()
							.map(Requested.Reference.init)
						
						processGetRequested{
							try Requested(
								record: requestedRecord,
								references: references
							)
						}
					}
					catch { processGetRequested{throw error} }
					
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
					){ processVerifyCompletion{} }
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
	
	/// - Parameters:
	///   - processVerify: that the save succeeded
	func save(
		_ record: CKRecord,
		processVerify: @escaping Process<Verify>
	){
		save(record){
			record, error in
			
			if let error = error {
				processVerify{throw error}
				return
			}
			
			processVerify{}
		}
	}
}
