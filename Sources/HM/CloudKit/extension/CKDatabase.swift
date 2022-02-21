import CloudKit

public extension CKDatabase {
  func modifyRecordsRecursivelyAsNeeded(
    saving recordsToSave: [CKRecord],
    deleting recordIDsToDelete: [CKRecord.ID]
  ) async throws {
    do {
      _ = try await modifyRecords(saving: recordsToSave, deleting: recordIDsToDelete)
    } catch let error as CKError {
      switch CKError.Code(rawValue: error.errorCode) {
      case.unknownItem:
        try await save(recordsToSave.first!)
        try await modifyRecordsRecursivelyAsNeeded(
          saving: .init(recordsToSave.dropFirst()),
          deleting: recordIDsToDelete
        )
      case .limitExceeded:
        for (recordsToSave, recordIDsToDelete)
        in zip(recordsToSave.splitInHalf, recordIDsToDelete.splitInHalf) {
          try await self.modifyRecordsRecursivelyAsNeeded(
            saving: recordsToSave,
            deleting: recordIDsToDelete
          )
        }
      default:
        throw error
      }
    }
  }
  
  /// Request `CKRecord`s that correspond to a Swift type.
  ///
  /// - Parameters:
  ///   - recordType: Its name has to be the same in your code, and in CloudKit.
  ///   - predicate: for the `CKQuery`
  func records<Record>(
    type _: Record.Type,
    predicate: NSPredicate = .init(value: true)
  ) async throws -> [CKRecord] {
    try await withThrowingTaskGroup(of: [CKRecord].self) { group in
      func process(
        _ records: (
          matchResults: [(CKRecord.ID, Result<CKRecord, Error>)],
          queryCursor: CKQueryOperation.Cursor?
        )
      ) async throws {
        group.addTask {
          try records.matchResults.map { try $1.get() }
        }
        
        if let cursor = records.queryCursor {
          try await process(self.records(continuingMatchFrom: cursor))
        }
      }
      
      try await process(
        records(
          matching: .init(
            recordType: "\(Record.self)",
            predicate: predicate
          )
        )
      )
      
      return try await group.reduce(into: [], +=)
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
    predicate: NSPredicate = .init(value: true),
    _ processGetRequested: @escaping ProcessGet<Requested>,
    _ processCompletionResult: @escaping (VerificationResult<Error>) -> Void
  ) {
    let dispatchGroup = DispatchGroup()
    
    func initialize(_ operation: CKQueryOperation) {
      operation.recordMatchedBlock = { _, result in
        let requestedRecord: CKRecord

        do {
          requestedRecord = try result.get()
        } catch {
          processGetRequested { throw error }
          return
        }

        guard let references = requestedRecord[Requested.referenceKey] as? [CKRecord.Reference]
        else {
          processGetRequested {
            throw InitializableWithCloudKitRecordAndReferencesExtensions.Error.emptyReferenceList
          }
          return
        }
        
        dispatchGroup.enter()
        
        let operation = CKFetchRecordsOperation(references: references) {
          do {
            let records = try $0.get()
            let references = try records.map(Requested.Reference.init)
            
            processGetRequested {
              try Requested(
                record: requestedRecord,
                references: references
              )
            }
          } catch {
            processGetRequested { throw error }
          }
          
          dispatchGroup.leave()
        }
        self.add(operation)
      }

      operation.queryResultBlock = { result in
        switch result {
        case .failure(let error):
          processCompletionResult(.init(failure: error))
        case .success(let cursor?):
          let operation = CKQueryOperation(cursor: cursor)
          initialize(operation)
          self.add(operation)
        case .success:
          dispatchGroup.notify(queue: .init(label: "")) {
            processCompletionResult(.init())
          }
        }
      }
    }
    
    let operation = CKQueryOperation(
      query: .init(
        recordType: "\(Requested.self)",
        predicate: predicate
      )
    )
    initialize(operation)
    add(operation)
  }
}
