import Foundation

extension NSURLCredential {
	convenience init(userName: String, password: String) {
		self.init(
			user: userName,
			password: password,
			persistence: .Synchronizable
		)
	}
}