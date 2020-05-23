import CloudKit

public extension CKFetchRecordsOperation {
  /// - Parameters:
  ///   - process: ID to record dictionary
  convenience init(
    recordIDs: [CKRecord.ID],
    process: @escaping (Result<[CKRecord.ID: CKRecord], Error>) -> Void
  ) {
    self.init(recordIDs: recordIDs)
    fetchRecordsCompletionBlock = Result.makeHandleCompletion(process)
  }

  /// - Parameters:
  ///   - process: records
  convenience init<References: Sequence>(
    references: References,
    process: @escaping (Result<[CKRecord], Error>) -> Void
  )
  where References.Element == CKRecord.Reference {
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
