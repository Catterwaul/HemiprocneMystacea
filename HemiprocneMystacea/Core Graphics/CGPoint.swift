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
		divisor: CGFloat
	) -> CGPoint {
		return CGPoint(
			x: point.x / divisor,
			y: point.y / divisor
		)
	}
}
