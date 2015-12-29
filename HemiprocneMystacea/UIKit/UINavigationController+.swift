extension UINavigationController {
	public final func push(viewController viewController: UIViewController, animated: Bool = true) {
		pushViewController(viewController, animated: animated)
	}
}