import UIKit

public extension UIBarButtonItem {
	func getView() -> UIView {
		return value(forKey: "view") as! UIView
	}
}
