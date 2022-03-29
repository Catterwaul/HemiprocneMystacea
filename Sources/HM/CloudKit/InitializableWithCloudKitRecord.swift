import CloudKit

public protocol InitializableWithCloudKitRecord {
	init(record: CKRecord) throws
}

public extension Array where Element: InitializableWithCloudKitRecord {
  init(
    database: CKDatabase,
    zoneID: CKRecordZone.ID? = nil,
    predicate: NSPredicate = .init(value: true)
  ) async throws {
    self = try await database.records(
      type: Element.self,
      zoneID: zoneID,
      predicate: predicate
    ).map(Element.init)
  }
}
