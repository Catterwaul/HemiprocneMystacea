import CloudKit

public extension CKContainer {
/// `userDiscoverability` is the only `CKApplicationPermissions`
  /// so we don't bother with any as an argument
  func requestApplicationPermissionStatus(
    process: @escaping ProcessGet<CKContainer.Application.PermissionStatus>
  ) {
    requestApplicationPermission(.userDiscoverability) { permissionStatus, error in
      if let error = error {
        process { throw error }
        return
      }
      
      process { permissionStatus }
    }
  }

  func requestUserIdentity(process: @escaping ProcessGet<CKUserIdentity>) {
    requestApplicationPermissionStatus { [unowned self] getStatus in
      do {
        let status = try getStatus()
        
        switch status {
        case .granted:
          self.fetchUserRecordID { [unowned self] recordID, error in
            if let error = error {
              process { throw error }
              return
            }
            
            self.discoverUserIdentity(withUserRecordID: recordID!) {
              userIdentity, error in
              
              if let error = error {
                process { throw error }
              }
              else { process { userIdentity! } }
            }
          }          
        default:
          break
        }
      }
      catch { process { throw error } }
    }
  }
}
