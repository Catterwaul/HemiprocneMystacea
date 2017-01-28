import QuartzCore

public extension CABasicAnimation {
	/// Should be `Values<Interpolable>`.
	/// Change that for Swift 3.1!
	public struct Values {
		public init<Interpolable>(
			from: Interpolable,
			to: Interpolable
		) {
			self.from = from as AnyObject
			self.to = to as AnyObject
		}
		
		let from: AnyObject
		let to: AnyObject
	}
}
