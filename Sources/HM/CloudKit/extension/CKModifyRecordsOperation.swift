import CloudKit

public extension CKModifyRecordsOperation {
  convenience init(
    recordsToSave: [CKRecord]? = nil,
    recordIDsToDelete: [CKRecord.ID]? = nil,
    _ processCompletionResult: @escaping Process<VerificationResult>
  ) {
    self.init(
      recordsToSave: recordsToSave,
      recordIDsToDelete: recordIDsToDelete
    )
    
    modifyRecordsCompletionBlock = {
      processCompletionResult( .init(failure: $2) )
    }
  }
}
