import UserNotifications

public extension UNUserNotificationCenter {
  func add(
    _ request: UNNotificationRequest,
    _ processVerifyAddition: Process<Verify>? = nil
  ) {
    add(
      request,
      withCompletionHandler:
        processVerifyAddition.map{
          processVerifyAddition in {
            error in
            
            if let error = error {
              processVerifyAddition{throw error}
              return
            }
            
            processVerifyAddition{}
          }
        }
    )
  }
  
	func requestAuthorization(
		options: UNAuthorizationOptions,
		processGetGranted: @escaping ProcessThrowingGet<Bool>
	) {
		requestAuthorization(
			options: options,
			completionHandler: {
				granted, error in
				
				if let error = error {
					processGetGranted{throw error}
					return
				}
				
				processGetGranted{granted}
			}
		)
	}
}
 
