import CloudKit

public protocol CloudKitBackReferencer: InitializableWithCloudKitRecord {
  associatedtype RequestResult
  
  /// One of the `CloudKitRecordKey`s
  static var backReferenceKey: String { get }
  
  static func makeRequestResult(
    backReferencer: Self,
    record: CKRecord
  ) -> RequestResult?
}

public extension CloudKitBackReferencer {
  static func request(
    database: CKDatabase,
    _ process: @escaping ProcessGet<[CKRecord.ID: [RequestResult]]>
  ) {
    database.request(recordType: self) { getRecords in
      process {
        let records = try getRecords()
        let idsAndResults = try records.compactMap {
          record -> (
            backReferenceID: CKRecord.ID,
            result: RequestResult
          )? in
          
          guard
            let backReference: CKRecord.Reference = try? record[backReferenceKey],
            
            case let backReferencer = try Self(record: record),
            let result = makeRequestResult(
              backReferencer: backReferencer,
              record: record
            )
          else { return nil }
          
          return (
            backReferenceID: backReference.recordID,
            result: result
          )
        }
        
        return
          Dictionary(grouping: idsAndResults, by: \.backReferenceID)
          .mapValues { $0.map(\.result) }
      }
    }
  }
}
