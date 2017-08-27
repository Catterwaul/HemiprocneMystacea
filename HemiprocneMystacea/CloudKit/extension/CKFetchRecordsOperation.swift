import CloudKit

public extension CKFetchRecordsOperation {
	/// - Parameters:
	///   - process: ID to record dictionary
	convenience init(
		recordIDs: [CKRecordID],
		process: @escaping ProcessThrowingGet<[CKRecordID: CKRecord]>
	) {
		self.init(recordIDs: recordIDs)
		fetchRecordsCompletionBlock = {
			records, error in
			
			if let error = error {
				process {throw error}
				return
			}
			
			process {records!}
		}
	}
	
	/// - Parameters:
	///   - process: records
	convenience init<References: Sequence>(
		references: References,
		process: @escaping ProcessThrowingGet<[CKRecord]>
	)
	where References.Element == CKReference {
		let iDs = references.map {$0.recordID}
		
		self.init(recordIDs: iDs) {
			getRecords in
			
			process{
				let records = try getRecords()
				return iDs.map {id in records[id]!}
			}
		}
	}
}
