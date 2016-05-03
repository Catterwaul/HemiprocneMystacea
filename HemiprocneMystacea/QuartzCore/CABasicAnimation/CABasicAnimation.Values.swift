public struct CABasicAnimation_Values {
	public init
	<Interpolable>
	(
		from: Interpolable,
		to: Interpolable
	) {
		self.from = from as! AnyObject
		self.to = to as! AnyObject
	}
	
	let
		from: AnyObject,
		to: AnyObject
}