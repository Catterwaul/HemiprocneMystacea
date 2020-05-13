import CloudKit

public extension CKDatabase {
  func addModifyRecordsOperationsAsNeeded(
    recordsToSave: [CKRecord],
    recordIDsToDelete: [CKRecord.ID],
    dispatchGroup: DispatchGroup,
    addToErrors: @escaping (Error) -> Void
  ) {
    dispatchGroup.enter()
    add(
      CKModifyRecordsOperation(
        recordsToSave: recordsToSave,
        recordIDsToDelete: recordIDsToDelete
      ) {
        [unowned self] verifyCompletion in
        
        defer { dispatchGroup.leave() }
        
        do { try verifyCompletion() }
        catch let error as CKError
        where CKError.Code(rawValue: error.errorCode) == .unknownItem {
          dispatchGroup.enter()
          self.save(recordsToSave.first!) { verify in
            defer { dispatchGroup.leave() }
            
            do {
              try verify()
              self.addModifyRecordsOperationsAsNeeded(
                recordsToSave: Array( recordsToSave.dropFirst() ),
                recordIDsToDelete: recordIDsToDelete,
                dispatchGroup: dispatchGroup,
                addToErrors: addToErrors
              )
            }
            catch let error { addToErrors(error) }
          }
        }
        catch let error as CKError
        where CKError.Code(rawValue: error.errorCode) == .limitExceeded {
          for (recordsToSave, recordIDsToDelete)
          in zip(recordsToSave.splitInHalf, recordIDsToDelete.splitInHalf) {
            self.addModifyRecordsOperationsAsNeeded(
              recordsToSave: recordsToSave,
              recordIDsToDelete: recordIDsToDelete,
              dispatchGroup: dispatchGroup,
              addToErrors: addToErrors
            )
          }
        }
        catch let error { addToErrors(error) }
      }
    )
  }
  
	/// Request `CKRecord`s that correspond to a Swift type.
	///
	/// - Parameters:
	///   - recordType: Its name has to be the same in your code, and in CloudKit.
	///   - predicate: for the `CKQuery`
	///   - process: processes a *throwing get [CKRecord]*
  func request<Requested>(
    recordType: Requested.Type,
    predicate: NSPredicate = NSPredicate(value: true),
    resultsLimit: Int? = nil,
    process: @escaping ProcessGet<[CKRecord]>
  ) {
    var records: [CKRecord] = []
    
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 1
    
    func initPhase2(_ operation: CKQueryOperation) {
      if let resultsLimit = resultsLimit {
        operation.resultsLimit = resultsLimit
      }
      operation.recordFetchedBlock = { record in
        operationQueue.addOperation { records.append(record) }
      }
      
      operation.queryCompletionBlock = { cursor, error in
        if let error = error {
          process { throw error }
        }
        else if let cursor = cursor {
          let operation = CKQueryOperation(cursor: cursor)
          initPhase2(operation)
          self.add(operation)
        }
        else {
          operationQueue.addOperation { process { records } }
        }
      }
    }
    
    let operation = CKQueryOperation(
      query: CKQuery(
        recordType: "\(Requested.self)",
        predicate: predicate
      )
    )
    initPhase2(operation)
    add(operation)
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
		process: @escaping ProcessGet<[Requested]>
	) {
		request(
			recordType: Requested.self,
			predicate: predicate
		) {
      getRecords in process {
				let records = try getRecords()
				return try records.map(Requested.init)
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
    _ processGetRequested: @escaping ProcessGet<Requested>,
    _ processVerifyCompletion: @escaping Process<Verify>
  ) {
    let dispatchGroup = DispatchGroup()
    
    func initialize(_ operation: CKQueryOperation) {
      operation.recordFetchedBlock = { requestedRecord in
        guard let references = requestedRecord[Requested.referenceKey] as? [CKRecord.Reference]
        else {
          processGetRequested {
            throw InitializableWithCloudKitRecordAndReferencesExtensions.Error.emptyReferenceList
          }
          return
        }
        
        dispatchGroup.enter()
        
        let operation = CKFetchRecordsOperation(references: references) {
          getRecords in
          
          do {
            let records = try getRecords()
            let references = try records.map(Requested.Reference.init)
            
            processGetRequested {
              try Requested(
                record: requestedRecord,
                references: references
              )
            }
          }
          catch { processGetRequested { throw error } }
          
          dispatchGroup.leave()
        }
        self.add(operation)
      }
			
      operation.queryCompletionBlock = { cursor, error in
        if let error = error {
          processVerifyCompletion { throw error }
        }
        else if let cursor = cursor {
          let operation = CKQueryOperation(cursor: cursor)
          initialize(operation)
          self.add(operation)
        }
        else {
          dispatchGroup.notify( queue: DispatchQueue(label: "") ) {
            processVerifyCompletion { }
          }
        }
      }
    }
		
    let operation = CKQueryOperation(
      query: CKQuery(
        recordType: "\(Requested.self)",
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
  ) {
    save(record) { record, error in
      if let error = error {
        processVerify { throw error }
        return
      }
      
      processVerify { }
    }
  }
}
