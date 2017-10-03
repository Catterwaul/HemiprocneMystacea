import CloudKit

public protocol CloudKitBackReferencer: InitializableWithCloudKitRecord {
	associatedtype RequestResult
	
	/// One of the `CloudKitRecordKey`s
	static var backReferenceKey: String {get}
	
	static func makeRequestResult(
		backReferencer: Self,
		record: CKRecord
	) -> RequestResult?
}

public extension CloudKitBackReferencer {
	static func request(
		database: CKDatabase,
		_ process: @escaping ProcessThrowingGet<[ CKRecordID: [RequestResult] ]>
	) {
		database.request(recordType: self) {
			getRecords in process{
				let idsAndResults = try getRecords().flatMap {
					record -> (
						backReferenceID: CKRecordID,
						result: RequestResult
					)? in
					
					guard
						let backReference: CKReference = record[backReferenceKey],
						
						case let backReferencer = try Self(record: record),
						let result = makeRequestResult(
							backReferencer: backReferencer,
							record: record
						)
					else {return nil}
					
					return (
						backReferenceID: backReference.recordID,
						result: result
					)
				}
        
        return
          Dictionary(grouping: idsAndResults) {$0.backReferenceID}
					.mapValues{ idsAndResults in idsAndResults.map {$0.result} }
			}
		}
	}
}
