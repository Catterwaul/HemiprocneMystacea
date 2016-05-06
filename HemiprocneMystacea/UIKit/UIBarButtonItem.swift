import UIKit

public extension UIBarButtonItem {
	func view_get() -> UIView {
		return valueForKey("view") as! UIView
	}
}