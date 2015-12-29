public protocol UIPageViewControllerDataSourceWithConnections: UIPageViewControllerDataSource {
    var connectedViewControllers: [UIViewController] {get}
}

public extension UIPageViewControllerDataSourceWithConnections {
    final func 😾pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController
    ) -> UIViewController? {return connectedViewController(
        current: viewController,
        adjustIndex: -
    )}
    final func 😾pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController
    ) -> UIViewController? {return connectedViewController(
        current: viewController,
        adjustIndex: +
    )}
    private func connectedViewController(
        current viewController: UIViewController,
        adjustIndex: (Int, Int) -> Int
    ) -> UIViewController? {
        let requestedIndex = adjustIndex(connectedViewControllers.indexOf(viewController)!, 1)
        return connectedViewControllers.indices.contains(requestedIndex) ?
            connectedViewControllers[requestedIndex] : nil
    }

    final func presentationCountForPageViewController(pageViewController: UIPageViewController)
    -> Int {return connectedViewControllers.count}
}