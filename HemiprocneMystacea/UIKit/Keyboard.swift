public struct Keyboard {
	public static let
		willShow📡 = 📡init(notificationName: UIKeyboardWillShowNotification),
		willHide📡 = 📡init(notificationName: UIKeyboardWillHideNotification)
}

public extension Keyboard {struct Frame📦 {
   init(userInfo: [String: NSValue]) {
      begin = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue()
      end = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
   }
   
   public let begin: CGRect, end: CGRect
}}

private func 📡init(notificationName notificationName: String)
 -> MultiClosure<Keyboard.Frame📦> {
   return NSNotificationCenter.📡init(
      notificationName: UIKeyboardWillShowNotification
   ){Keyboard.Frame📦(userInfo: $0 as! [String: NSValue])}
}