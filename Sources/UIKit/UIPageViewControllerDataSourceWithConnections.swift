#if !os(macOS)
import UIKit

public protocol UIPageViewControllerDataSourceWithConnectedViewControllers: UIPageViewControllerDataSource {
	var _connectedViewControllers: [UIViewController] { get }
}

public extension UIPageViewControllerDataSourceWithConnectedViewControllers {
	var connectedViewControllers: UIPageViewController.ConnectedViewControllers {
    UIPageViewController.ConnectedViewControllers(
			connectedViewControllers: _connectedViewControllers
		)
	}
}

public extension UIPageViewController {
  struct ConnectedViewControllers {
    fileprivate let connectedViewControllers: [UIViewController]
  }
}

// MARK: public
public extension UIPageViewController.ConnectedViewControllers {
	subscript(successor viewController: UIViewController) -> UIViewController? {
    getConnectedViewController(
			viewController: viewController,
			adjustIndex: -
		)
	}
	
	subscript(predecessor viewController: UIViewController) -> UIViewController? {
    getConnectedViewController(
			viewController: viewController,
			adjustIndex: +
		)
	}
}

// MARK: private
private extension UIPageViewController.ConnectedViewControllers {
  func getConnectedViewController(
    viewController: UIViewController,
    adjustIndex: (Int, Int) -> Int
  ) -> UIViewController? {
    guard
      let requestedIndex = (
        connectedViewControllers.firstIndex(of: viewController)
        .map { adjustIndex($0, 1) }
      ),
      connectedViewControllers.indices.contains(requestedIndex)
    else { return nil }
    
    return connectedViewControllers[requestedIndex]
  }
}
#endif
