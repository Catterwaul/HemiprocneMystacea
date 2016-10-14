import CloudKit

public extension CKFetchRecordsOperation {
	convenience init(
		references: [CKReference],
		process: @escaping Process<() throws -> [CKRecord]>
	) {
		let iDs = references.map{$0.recordID}
		
		self.init(recordIDs: iDs)
		fetchRecordsCompletionBlock = {
			records, error in
			
			if let error = error {
				process{throw error}
				return
			}
			
			process{
				iDs.map{records![$0]!}
			}
		}
	}
}
