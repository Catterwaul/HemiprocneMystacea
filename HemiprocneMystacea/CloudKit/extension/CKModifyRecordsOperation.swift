import CloudKit

public extension CKModifyRecordsOperation {
	convenience init(
		recordsToSave: [CKRecord]? = nil,
		recordIDsToDelete: [CKRecord.ID]? = nil,
		_ processVerifyCompletion: @escaping Process<Verify>
	) {
		self.init(
			recordsToSave: recordsToSave,
			recordIDsToDelete: recordIDsToDelete
		)
		modifyRecordsCompletionBlock = {
			savedRecords,
			deletedRecordIDs,
			operationError
			in
		
			if let error = operationError {
				processVerifyCompletion { throw error }
				return
			}
			
			processVerifyCompletion { }
		}
	}
}
