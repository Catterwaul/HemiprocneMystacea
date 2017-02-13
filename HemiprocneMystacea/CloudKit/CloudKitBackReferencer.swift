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
		_ process: @escaping Process<
			() throws -> [ CKRecordID: [RequestResult] ]
		>
	) {
		database.request(recordType: self){
			getRecords in process{
				let idsAndResults = try getRecords().flatMap{
					record -> (
						backReferenceID: CKRecordID,
						result: RequestResult
					)? in
					
					guard
						let backReference: CKReference = record.getValue(key: backReferenceKey),
						
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
				
				return Dictionary(
					idsAndResults
					.grouped{$0.backReferenceID}
					.map{
						id, idsAndResults in (
							id,
							idsAndResults.map{$0.result}
						)
					}
				)
			}
		}
	}
}