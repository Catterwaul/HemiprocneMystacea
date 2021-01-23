#if !os(watchOS)
import QuartzCore

public extension CABasicAnimation {
  struct Values {
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
#endif
