import UIKit

public extension UIViewController {
  static func instantiate() -> Self? {
    UIViewController.instantiate()
  }
  
  static func instantiate<ViewController: UIViewController>(
    storyboard: UIStoryboard = UIStoryboard(
      name: "\(ViewController.self)",
      bundle: nil
    )
  ) -> ViewController? {
    storyboard.instantiateInitialViewController() as? ViewController
  }


  /// - Returns: all children of type `ViewController`
  func getChildren<ViewController: UIViewController>() -> [ViewController] {
    children.compactMap { $0 as? ViewController }
  }

  /// - Returns: the first child of type `ViewController`
  func getChild<ViewController: UIViewController>() -> ViewController? {
    getChildren().first
  }

  
	final func presentActionSheet(
		title: String? = nil,
		message: String? = nil,
		actions: [UIAlertAction] = [UIAlertAction.`default`],
		animated: Bool = true,
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
	
		present(
			viewController,
			animated: animated
		)
	}
	
	final func presentAlert(
		title: String? = nil,
		message: String? = nil,
		actions: [UIAlertAction] = [UIAlertAction.`default`],
		animated: Bool = true
	) {
		present(
			UIAlertController(
				title: title,
				message: message,
				style: .alert,
				actions: actions
			),
			animated: false
		)
	}
}