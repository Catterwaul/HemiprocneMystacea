import CloudKit

public extension CKContainer {
  /// `userIdentity(forUserRecordID: userRecordID())`
  var userIdentity: CKUserIdentity? {
    get async throws {
      try await userIdentity(forUserRecordID: userRecordID())
    }
  }
}
