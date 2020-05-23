import UserNotifications

public extension UNUserNotificationCenter {
  func add(
    _ request: UNNotificationRequest,
    _ processAdditionResult: ( (VerificationResult<Error>) -> Void )? = nil
  ) {
    add(
      request,
      withCompletionHandler:
        processAdditionResult.map {
          processAdditionResult in {
            processAdditionResult( .init(failure: $0) )
          }
        }
    )
  }
  
  func requestAuthorization(
    options: UNAuthorizationOptions,
    process: @escaping (Result<Bool, Error>) -> Void
  ) {
    requestAuthorization(
      options: options,
      completionHandler: Result.makeHandleCompletion(process)
    )
  }
}
 
