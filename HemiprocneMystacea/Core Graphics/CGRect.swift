import CoreGraphics

public extension CGRect {
	var center: CGPoint {
		return CGPoint(
			x: midX,
			y: midY
		)
	}
	
	var max: CGPoint {
		return CGPoint(
			x: maxX,
			y: maxY
		)
	}
	
//MARK: init
	init(
		x: CGFloat,
		y: CGFloat,
		size: CGSize
	) {
		self.init(
			origin: CGPoint(
				x: x,
				y: y
			),
			size: size
		)
	}

	init(
		_ rect: CGRect,
		height: CGFloat
	) {
		self.init(
			x: rect.origin.x,
			y: rect.origin.y,
			width: rect.width,
			height: height
		)
	}
}
