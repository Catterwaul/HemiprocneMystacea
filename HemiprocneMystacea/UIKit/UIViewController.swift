import UIKit

public extension UIViewController {	
	final func dismiss(
		animated: Bool = true,
		respondToViewDidDisappear: ( () -> () )? = nil
	) {
		dismiss(
			animated: animated,
			completion: respondToViewDidDisappear
		)
	}
	
	final func performSegue(identifier: String) {
		performSegue(
			withIdentifier: identifier,
			sender: self
		)
	}
	
	final func present(
		viewController: UIViewController,
		animated: Bool = true,
		respondToViewDidAppear: ( () -> () )? = nil
	) {
		present(
			viewController,
			animated: animated,
			completion: respondToViewDidAppear
		)
	}

	final func presentActionSheet(
		title: String? = nil,
		message: String? = nil,
		actions: [UIAlertAction] = [UIAlertAction.`default`],
		sourceView: UIView
	) {
		let viewController = UIAlertController(
			title: title,
			message: message,
			style: .actionSheet,
			actions: actions
		)
		
		if let popoverPresentationController = viewController.popoverPresentationController {
			popoverPresentationController.sourceView = sourceView
			popoverPresentationController.sourceRect = sourceView.bounds
		}
	
		present(viewController: viewController)
	}
	
	final func presentAlert(
		title: String? = nil,
		message: String? = nil,
		actions: [UIAlertAction] = [UIAlertAction.`default`]
	) {
		present(
			viewController: UIAlertController(
				title: title,
				message: message,
				style: .alert,
				actions: actions
			)
		)
	}
}
