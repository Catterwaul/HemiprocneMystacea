import UIKit

public extension UIViewController {
  static func instantiate<ViewController: UIViewController>(
    init: ( (NSCoder) -> ViewController )?
  ) -> ViewController? {
    UIStoryboard(name: "\(ViewController.self)", bundle: nil)
    .instantiateInitialViewController(creator: `init`)
  }

  /// Instantiate a view controller without relying on an identifier.
  ///
  ///     let viewController: ViewController = .instantiate(storyboard: storyboard) {
  ///       .init(coder: $0, dependency: dependency)
  ///     }
  static func instantiate<ViewController: UIViewController>(
    storyboard: UIStoryboard, init: ( (NSCoder) -> ViewController )?
  ) -> ViewController {
    storyboard.instantiateViewController(
      identifier: "\(ViewController.self)", creator: `init`
    )
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
