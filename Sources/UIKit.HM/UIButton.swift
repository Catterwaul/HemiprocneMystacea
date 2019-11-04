import UIKit

public extension UIButton {
	/// A simple way to visibily show that a user interaction is disabled
	final var disabledAndDim: Bool {
		get { !isEnabled }
		set {
			isEnabled = !newValue
			alpha =
        newValue
				? 0.5
				: 1
		}
	}
}
