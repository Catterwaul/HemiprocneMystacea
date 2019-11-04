import CloudKit

public extension CKFetchRecordsOperation {
	/// - Parameters:
	///   - process: ID to record dictionary
	convenience init(
		recordIDs: [CKRecord.ID],
		process: @escaping ProcessGet<[CKRecord.ID: CKRecord]>
	) {
		self.init(recordIDs: recordIDs)
		fetchRecordsCompletionBlock = { records, error in
			if let error = error {
				process { throw error }
				return
			}
			
			process { records! }
		}
	}
	
	/// - Parameters:
	///   - process: records
	convenience init<References: Sequence>(
		references: References,
		process: @escaping ProcessGet<[CKRecord]>
	)
  where References.Element == CKRecord.Reference {
		let ids = references.map { $0.recordID }
		
		self.init(recordIDs: ids) {
			getRecords in
			
			process {
				let records = try getRecords()
				return ids.map { id in records[id]! }
			}
		}
	}
}
