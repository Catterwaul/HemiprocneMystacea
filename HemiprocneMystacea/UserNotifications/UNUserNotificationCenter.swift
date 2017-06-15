import UserNotifications

public extension UNUserNotificationCenter {
  func add(
    _ request: UNNotificationRequest,
    _ processverifyAddition: Process<Verify>? = nil
  ) {
    add(
      request,
      withCompletionHandler:
        processverifyAddition.map{
          processverifyAddition in {
            error in
            
            if let error = error {
              processverifyAddition{throw error}
              return
            }
            
            processverifyAddition{}
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
 
