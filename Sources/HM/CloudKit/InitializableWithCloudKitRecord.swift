import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord) throws
}

public extension Array where Element: InitializableWithCloudKitRecord {
  init(
    database: CKDatabase,
    predicate: NSPredicate = NSPredicate(value: true)
  ) async throws {
    self = try await database.records(
      type: Element.self
      predicate: predicate
    ).map(Element.init)
  }
}
