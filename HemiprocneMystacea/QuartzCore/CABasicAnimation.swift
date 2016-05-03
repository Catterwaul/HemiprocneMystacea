import QuartzCore

public extension CABasicAnimation {
	convenience init
	<Interpolable: AnyObject>
	(
		keyPath: String,
		values: CABasicAnimation_Values<Interpolable>,
		duration: CFTimeInterval
	) {
		self.init(keyPath: keyPath)
		
		fromValue = values.from
		toValue = values.to
		
		self.duration = duration
	}
}