public extension UINavigationController {
  final func push(
    viewController viewController: UIViewController,
    animated: Bool = true
  ) {
    pushViewController(viewController, animated: animated)
  }
}