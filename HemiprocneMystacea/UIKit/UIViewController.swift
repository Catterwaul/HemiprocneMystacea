public extension UIViewController {
	final func dismiss(
		animated: Bool = true,
		📻viewDidDisappear: (() -> ())? = nil
	) {
		dismissViewControllerAnimated(animated,
			completion: 📻viewDidDisappear
		)
	}
	
	final func performSegue(identifier identifier: String) {
		performSegueWithIdentifier(identifier, sender: self)
	}
	
	final func present(
		viewController viewController: UIViewController,
		animated: Bool = true,
		📻viewDidAppear: (() -> ())? = nil
	) {
		presentViewController(viewController,
			animated: animated,
			completion: 📻viewDidAppear
		)
	}

	final func presentActionSheet(
		title title: String? = nil,
		message: String? = nil,
		actions: [UIAlertAction] = [UIAlertAction.`default`],
		sourceView: UIView
	) {
		present(
			viewController: UIAlertController(
				title: title,
				message: message,
				style: .ActionSheet,
				actions: actions
			)…{
				guard let popoverPresentationController = $0.popoverPresentationController
				else {return}
				
				popoverPresentationController…{
					$0.sourceView = sourceView
					$0.sourceRect = sourceView.bounds
				}
			}
		)
	}
	
	final func presentAlert(
		title title: String? = nil,
		message: String? = nil,
		actions: [UIAlertAction] = [UIAlertAction.`default`]
	) {
		present(
			viewController: UIAlertController(
				title: title,
				message: message,
				style: .Alert,
				actions: actions
			)
		)
	}
}