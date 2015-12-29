public struct Keyboard {
	public static var
		willShow📡 = Keyboard.📡(UIKeyboardWillShowNotification),
		willHide📡 = Keyboard.📡(UIKeyboardWillHideNotification)
	
	private static func 📡(notificationName: String) -> MultiClosure<CGFloat> {
		let 📡 = MultiClosure<CGFloat>()
		NSNotificationCenter.defaultCenter().addObserverForName(notificationName,
			object: nil,
			queue: NSOperationQueue.mainQueue()
		) {
			📡[
				($0.userInfo as! [String: NSValue])[UIKeyboardFrameBeginUserInfoKey]!
					.CGRectValue().height
			]
		}
		return 📡
	}
}