public extension UIViewController {
	final func dismissViewController(animated: Bool = true) {
		dismissViewControllerAnimated(animated, completion: nil)
	}
	
	final func performSegue(identifier identifier: String) {
		performSegueWithIdentifier(identifier, sender: self)
	}

	final func presentAlert(
		title title: String? = nil,
		message: String? = nil,
		style: UIAlertControllerStyle = .Alert,
		actions: [UIAlertAction] = [UIAlertAction.`default`]
	) {
		present(
			viewController: UIAlertController(
				title: title,
				message: message,
				style: style,
				actions: actions
			)
		)
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
}