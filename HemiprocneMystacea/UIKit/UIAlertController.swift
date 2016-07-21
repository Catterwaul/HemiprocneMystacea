import UIKit

public extension UIAlertController {
	convenience init(
		title: String?,
		message: String?,
		style: UIAlertControllerStyle = .alert,
		actions: [UIAlertAction] = [UIAlertAction.`default`]
	) {
		self.init(
			title: title,
			message: message,
			preferredStyle: style
		)
		self += actions
	}
}

//MARK: +=
public func += (
	controller: UIAlertController,
	action: UIAlertAction
) {
	controller.addAction(action)
}

public func += (
	controller: UIAlertController,
	actions: [UIAlertAction]
) {
	actions.forEach{controller += $0}
}
