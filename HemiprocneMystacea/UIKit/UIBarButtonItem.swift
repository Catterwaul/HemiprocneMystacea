import UIKit

public extension UIBarButtonItem {
	func view_get() -> UIView {
		return value(forKey: "view") as! UIView
	}
}
