import CloudKit

/// Back-referenced by one `CloudKitBackReferencer` type
public protocol CloudKitBackReferenced {
	associatedtype BackReferencer: CloudKitBackReferencer
	
	init(
		record: CKRecord,
		backReferencerRequestResults: [BackReferencer.RequestResult]
	) throws
}

public extension CloudKitBackReferenced {
	/// Fetches the `BackReferencer`s and uses them to initialize
	/// the `Self`s that they reference.
	///
	/// - Parameters:
	///   - process: all the selfs that can be created successfully,
	///		or an error if their records can't be gotten.
	static func request(
		database: CKDatabase,
		_ process: @escaping Process<() throws -> [Self]>
	) {
		BackReferencer.request(database: database){
			(	getResults: () throws -> [
					CKRecordID: [BackReferencer.RequestResult]
				]
			) in
			
			do {
				let results = try getResults()
				
				let operation = CKFetchRecordsOperation(
					recordIDs: Array(results.keys)
				){	getRecords in process{
						try getRecords().flatMap{
							iD, record in try? Self(
								record: record,
								backReferencerRequestResults: results[iD]!
							)
						}
					}
				}
				database.add(operation)
			}
			catch {
				process{throw error}
			}
		}
	}
}