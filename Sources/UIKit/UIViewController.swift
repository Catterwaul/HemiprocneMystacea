#if !os(macOS)
import UIKit

public extension UIViewController {
  /// Instantiates a view controller without `identifier` arguments.
  ///
  ///     let view🎮: View🎮 = .instantiate {
  ///       .init(coder: $0, dependency: dependency)
  ///     }!
  ///
  /// - Precondition:
  ///   1. There is a storyboard with the same name as `ViewController`.
  ///   2.  `ViewController` is the initial view controller for that storyboard.
  static func instantiate<ViewController: UIViewController>(
    bundle: Bundle? = nil,
    init: ((NSCoder) -> ViewController )?
  ) -> ViewController? {
    UIStoryboard(name: "\(ViewController.self)", bundle: bundle)
    .instantiateInitialViewController(creator: `init`)
  }

  /// Instantiate a view controller without relying on an `identifier` argument.
  ///
  ///     let view🎮: View🎮 = .instantiate(storyboard: storyboard) {
  ///       .init(coder: $0, dependency: dependency)
  ///     }
  ///
  /// - Precondition:
  ///   `storyboard` contains a view controller whose identifier has the same name as `ViewController`.
  static func instantiate<ViewController: UIViewController>(
    storyboard: UIStoryboard, init: ((NSCoder) -> ViewController )?
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

  final func present(_ viewController: UIViewController, animated: Bool) async {
    await withCheckedContinuation { continuation in
      present(viewController, animated: animated) {
        continuation.resume()
      }
    }
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
#endif
