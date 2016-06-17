public struct Keyboard {
	public static let
	willShow📡 = 📡init(notificationName: .UIKeyboardWillShow),
	willHide📡 = 📡init(notificationName: .UIKeyboardWillHide)
}

public extension Keyboard {
	struct Frame📦 {
		public let
		begin: CGRect,
		end: CGRect
	}
}

private extension Keyboard.Frame📦 {
	init(userInfo: [String: NSValue]) {
		begin = userInfo[UIKeyboardFrameBeginUserInfoKey]!.cgRectValue()
		end = userInfo[UIKeyboardFrameEndUserInfoKey]!.cgRectValue()
	}
}

private func 📡init
(notificationName: Notification.Name) -> MultiClosure<Keyboard.Frame📦> {
	return NotificationCenter.📡init(notificationName: notificationName){
		Keyboard.Frame📦(userInfo: $0 as! [String: NSValue])
	}
}
