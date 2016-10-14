import UIKit

public extension UIBarButtonItem {
	func get_view() -> UIView {
		return value(forKey: "view") as! UIView
	}
}
