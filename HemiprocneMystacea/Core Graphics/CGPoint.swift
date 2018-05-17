import CoreGraphics

public extension CGPoint {
	static func / (
		dividend: CGPoint,
		divisor: CGPoint
	) -> CGPoint {
		return CGPoint(
			x: dividend.x / divisor.x,
			y: dividend.y / divisor.y
		)
	}
	
	static func / (
		point: CGPoint,
		float: CGFloat
	) -> CGPoint {
		return CGPoint(
			x: point.x / float,
			y: point.y / float
		)
	}
}
