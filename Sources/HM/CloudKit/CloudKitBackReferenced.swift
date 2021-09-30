import CloudKit

/// Back-referenced by one `CloudKitBackReferencer` type
public protocol CloudKitBackReferenced {
  associatedtype BackReferencer: CloudKitBackReferencer
  
  init(
    record: CKRecord,
    backReferencerRequestResults: [BackReferencer.RequestResult]
  ) throws
}

public extension Array where Element: CloudKitBackReferenced {
  /// Fetches the `BackReferencer`s and uses them to initialize
  /// the `Self`s that they reference.
  init(database: CKDatabase) async throws {
    let results = try await Element.BackReferencer.request(database: database)
    self = try await database.records(for: .init(results.keys)).map { record in
      try .init(
        record: record.value.get(),
        backReferencerRequestResults: results[record.key]!
      )
    }
  }
}
