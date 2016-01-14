public extension UIViewController {
   final func dismissViewController(animated: Bool = true) {
      dismissViewControllerAnimated(animated, completion: nil)
   }

   final func performSegue(identifier identifier: String) {
      performSegueWithIdentifier(identifier, sender: self)
   }

	final func presentAlert(
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
	
	final func present(
		viewController viewController: UIViewController,
		animated: Bool = true,
		🔜: (() -> ())? = nil
	) {
		presentViewController(viewController, animated: animated, completion: 🔜)
	}
}