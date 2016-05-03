public struct CABasicAnimation_Values
<Interpolable: AnyObject>
{
	public init(
		from: Interpolable,
		to: Interpolable
	) {
		self.from = from
		self.to = to
	}
	
	let
		from: Interpolable,
		to: Interpolable
}