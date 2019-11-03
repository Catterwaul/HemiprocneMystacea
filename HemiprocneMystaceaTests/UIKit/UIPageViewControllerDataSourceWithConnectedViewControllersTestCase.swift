import HM
import XCTest
import UIKit

final class UIPageViewControllerDataSourceWithConnectedViewControllersTestCase: XCTestCase {
  func test_connectedViewControllers() {
    let pageViewController = PageViewController()

    XCTAssertNil(
      pageViewController.pageViewController(
        pageViewController,
        viewControllerBefore: pageViewController._connectedViewControllers.first!
      )
    )

    XCTAssertEqual(
      pageViewController.pageViewController(
        pageViewController,
        viewControllerAfter: pageViewController._connectedViewControllers.first!
      ),
      pageViewController._connectedViewControllers.last!
    )

    XCTAssertEqual(
      pageViewController.pageViewController(
        pageViewController,
        viewControllerBefore: pageViewController._connectedViewControllers.last!
      ),
      pageViewController._connectedViewControllers.first!
    )

    XCTAssertNil(
      pageViewController.pageViewController(
        pageViewController,
        viewControllerAfter: pageViewController._connectedViewControllers.last!
      )
    )
  }
}

private final class PageViewController: UIPageViewController {
//MARK: UIPageViewControllerDataSourceWithConnectedViewControllers
  let _connectedViewControllers = [UIViewController(), UIViewController()]
}

//MARK: UIPageViewControllerDataSourceWithConnectedViewControllers
extension PageViewController: UIPageViewControllerDataSourceWithConnectedViewControllers {
//MARK: UIPageViewControllerDataSource
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    connectedViewControllers[successor: viewController]
  }

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    connectedViewControllers[predecessor: viewController]
  }
}
