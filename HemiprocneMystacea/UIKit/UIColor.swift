import UIKit

public extension UIColor {
	var hsba: (
		hue: CGFloat,
		saturation: CGFloat,
		brightness: CGFloat,
		alpha: CGFloat
	) {
		var hsba = (
			hue: CGFloat(),
			saturation: CGFloat(),
			brightness: CGFloat(),
			alpha: CGFloat()
		)
		getHue(
			&hsba.hue,
			saturation: &hsba.saturation,
			brightness: &hsba.brightness,
			alpha: &hsba.alpha
		)
		return hsba
	}
}
