import CloudKit

public extension CKModifyRecordsOperation {
  convenience init(
    recordsToSave: [CKRecord]? = nil,
    recordIDsToDelete: [CKRecord.ID]? = nil,
    _ processCompletionResult: @escaping (VerificationResult<Error>) -> Void
  ) {
    self.init(
      recordsToSave: recordsToSave,
      recordIDsToDelete: recordIDsToDelete
    )
    
    modifyRecordsCompletionBlock = {
      processCompletionResult(.init(failure: $2))
    }
  }
}
