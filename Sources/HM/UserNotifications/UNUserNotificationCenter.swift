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
		processGetGranted: @escaping ProcessGet<Bool>
	) {
		requestAuthorization(
			options: options,
			completionHandler: { granted, error in
				if let error = error {
					processGetGranted { throw error }
					return
				}
				
				processGetGranted { granted }
			}
		)
	}
}
 
