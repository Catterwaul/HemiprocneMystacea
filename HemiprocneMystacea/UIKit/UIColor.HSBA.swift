import UIKit

public extension UIColor {
	public struct HSBA {
 		public var hue: CGFloat
		public var saturation: CGFloat
		public var brightness: CGFloat
		public var alpha: CGFloat
	}
	
	convenience init(_ hsba: HSBA) {
		self.init(
			hue: hsba.hue,
			saturation: hsba.saturation,
			brightness: hsba.brightness,
			alpha: hsba.alpha
		)
	}
}

public extension UIColor.HSBA {
	init(_ color: UIColor) throws {
		var hsba = UIColor.HSBA(
			hue: CGFloat(),
			saturation: CGFloat(),
			brightness: CGFloat(),
			alpha: CGFloat()
		)
		
		guard color.getHue(
			&hsba.hue,
			saturation: &hsba.saturation,
			brightness: &hsba.brightness,
			alpha: &hsba.alpha
		) else {
			struct Error: Swift.Error {}
			throw Error()
		}
		
		self = hsba
	}
}
