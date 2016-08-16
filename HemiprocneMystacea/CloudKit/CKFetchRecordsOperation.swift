import CloudKit

public extension CKFetchRecordsOperation {
	convenience init(
		references: [CKReference],
		process﹙get_records﹚: AsynchronouslyProcess<() throws -> [CKRecord]>
	) {
		let iDs = references.map{$0.recordID}
		
		self.init(recordIDs: iDs)
		fetchRecordsCompletionBlock = {
			records, error in
			
			if let error = error {
				process﹙get_records﹚{throw error}
				return
			}
			
			process﹙get_records﹚{
				iDs.map{records![$0]!}
			}
		}
	}
}
