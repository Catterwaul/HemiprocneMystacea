public extension UIViewController {
	final func dismiss(
		animated: Bool = true,
		📻viewDidDisappear: (() -> ())? = nil
	) {
		dismiss(
			animated: animated,
			completion: 📻viewDidDisappear
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
		📻viewDidAppear: (() -> ())? = nil
	) {
		present(viewController,
			animated: animated,
			completion: 📻viewDidAppear
		)
	}

	final func presentActionSheet(
		title: String? = nil,
		message: String? = nil,
		actions: [UIAlertAction] = [UIAlertAction.`default`],
		sourceView: UIView
	) {
		present(
			viewController: UIAlertController(
				title: title,
				message: message,
				style: .actionSheet,
				actions: actions
			)…{
				$0.popoverPresentationController ?… {
					$0.sourceView = sourceView
					$0.sourceRect = sourceView.bounds
				}
			}
		)
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
