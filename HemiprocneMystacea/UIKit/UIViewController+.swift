public extension UIViewController {
   func dismissViewController(animated: Bool = true) {
      dismissViewControllerAnimated(animated, completion: nil)
   }

   func performSegue(identifier identifier: String) {
      performSegueWithIdentifier(identifier, sender: self)
   }

	func presentAlert(
		title title: String?,
		message: String? = nil,
      style: UIAlertControllerStyle = .Alert,
		actions: [UIAlertController.Action]? = nil
	) {
		let alert: UIAlertController
		if let actions = actions {alert = UIAlertController(
			title: title,
			message: message,
         style: style,
			actions: actions
		)} else {alert = UIAlertController(
         title: title,
         message: message,
         style: style
      )}
		presentViewController(alert, animated: true, completion: nil)
	}
	
	func present(
		viewController viewController: UIViewController,
		animated: Bool = true,
		🔜: (() -> ())? = nil
	) {
		presentViewController(viewController, animated: animated, completion: 🔜)
	}
}