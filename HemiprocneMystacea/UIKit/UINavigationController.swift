public extension UINavigationController {
  final func push(
    viewController: UIViewController,
    animated: Bool = true
  ) {
    pushViewController(viewController, animated: animated)
  }
}
