import CloudKit

public extension CKContainer {
  /// `userDiscoverability` is the only `CKApplicationPermissions`
  /// so we don't bother with any as an argument.
  func requestApplicationPermissionStatus(
    process: @escaping (Result<Application.PermissionStatus, Error>) -> Void
  ) {
    requestApplicationPermission(
      .userDiscoverability,
      completionHandler: Result.makeHandleCompletion(process)
    )
  }

  func requestUserIdentity(process: @escaping (Result<CKUserIdentity, Error>) -> Void) {
    requestApplicationPermissionStatus { [unowned self] statusResult in
      switch statusResult {
      case .success(let status) where status == .granted:
        self.fetchUserRecordID(
          completionHandler: Result.makeHandleCompletion(
            processSuccess: { [unowned self] id in
              self.discoverUserIdentity(
                withUserRecordID: id,
                completionHandler: Result.makeHandleCompletion(process)
              )
            },
            processFailure: process
          )
        )
      case .failure(let error):
        process(.failure(error))
      case .success:
        break
      }
    }
  }
}
