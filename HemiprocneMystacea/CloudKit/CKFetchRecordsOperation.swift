import CloudKit

public extension CKFetchRecordsOperation {
	convenience init(
		references: [CKReference],
		process: Process<
			Throwing.Get<[CKRecord]>
		>
	) {
		self.init(recordIDs: references.map{$0.recordID})
		fetchRecordsCompletionBlock = {
			records, error in
			
			if let error = error {
				process{throw error}
				return
			}
			
			process{[CKRecord](records!.values)}
		}
	}
}
