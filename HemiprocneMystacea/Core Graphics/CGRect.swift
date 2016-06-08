public extension CGRect {
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

	var max: CGPoint {
		return CGPoint(
			x: maxX,
			y: maxY
		)
	}
}