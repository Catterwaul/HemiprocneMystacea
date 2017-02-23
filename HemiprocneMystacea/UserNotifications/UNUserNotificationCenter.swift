import UserNotifications

public extension UNUserNotificationCenter {
	func requestAuthorization(
		options: UNAuthorizationOptions,
		processGetGranted: @escaping Process<() throws -> Bool>
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
 
