import CloudKit

public extension CKFetchRecordsOperation {
	convenience init(
		recordIDs: [CKRecordID],
		process: @escaping Process<() throws -> [CKRecordID: CKRecord]>
	) {
		self.init(recordIDs: recordIDs)
		fetchRecordsCompletionBlock = {
			records, error in
			
			if let error = error {
				process{throw error}
				return
			}
			
			process{records!}
		}
	}
	
	convenience init<References: Sequence>(
		references: References,
		process: @escaping Process<() throws -> [CKRecord]>
	)
	where References.Iterator.Element == CKReference {
		let iDs = references.map{$0.recordID}
		
		self.init(recordIDs: iDs){
			getRecords in process{
				try iDs.map{try getRecords()[$0]!}
			}
		}
	}
}
