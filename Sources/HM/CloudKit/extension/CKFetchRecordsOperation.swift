import CloudKit
import typealias Combine.Future

public extension CKFetchRecordsOperation {
  /// - Parameters:
  ///   - process: ID to record dictionary
  convenience init(
    recordIDs: [CKRecord.ID],
    process: @escaping Future<[CKRecord.ID: CKRecord], Error>.Promise
  ) {
    self.init(recordIDs: recordIDs)
    fetchRecordsCompletionBlock = Result.makeHandleCompletion(process)
  }

  /// - Parameters:
  ///   - process: records
  convenience init(
    references: some Sequence<CKRecord.Reference>,
    process: @escaping Future<[CKRecord], Error>.Promise
  ) {
    let ids = references.map(\.recordID)
    self.init(recordIDs: ids) { result in
      process(
        result.map { records in
          ids.map { records[$0]! }
        }
      )
    }
  }
}
