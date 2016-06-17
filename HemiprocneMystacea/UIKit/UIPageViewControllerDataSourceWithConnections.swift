public protocol UIPageViewControllerDataSourceWithConnections: UIPageViewControllerDataSource {
  var connectedViewControllers: [UIViewController] {get}
}

public extension UIPageViewControllerDataSourceWithConnections {
  final func 😾pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBeforeViewController viewController: UIViewController
  ) -> UIViewController? {
    return connectedViewController(
      current: viewController,
      adjustIndex: -
    )
  }
  
  final func 😾pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfterViewController viewController: UIViewController
  ) -> UIViewController? {
    return connectedViewController(
      current: viewController,
      adjustIndex: +
    )
  }
  
  private func connectedViewController(
    current viewController: UIViewController,
    adjustIndex: (Int, Int) -> Int
  ) -> UIViewController? {
    let requestedIndex = adjustIndex(
      connectedViewControllers.index(of: viewController)!,
      1
    )
    return connectedViewControllers.indices.contains(requestedIndex)
      ? connectedViewControllers[requestedIndex]
      : nil
  }
  
  final func presentationCountForPageViewController
  (_ pageViewController: UIPageViewController) -> Int {
    return connectedViewControllers.count
  }
}
