public struct Keyboard {
	public static let
	willShow📡 = 📡init(notificationName: .UIKeyboardWillShow),
	willHide📡 = 📡init(notificationName: .UIKeyboardWillHide)
}

public extension Keyboard {
	struct Frames {
		public let
		begin: CGRect,
		end: CGRect
	}
}

private extension Keyboard.Frames {
	init(userInfo: [String: NSValue]) {
		begin = userInfo[UIKeyboardFrameBeginUserInfoKey]!.cgRectValue()
		end = userInfo[UIKeyboardFrameEndUserInfoKey]!.cgRectValue()
	}
}

private func 📡init
(notificationName: Notification.Name) -> MultiClosure<Keyboard.Frames> {
	return NotificationCenter.📡init(notificationName: notificationName){
		Keyboard.Frames(userInfo: $0 as! [String: NSValue])
	}
}
