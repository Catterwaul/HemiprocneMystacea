public extension ExpressibleByIntegerLiteral where Self: IntegerArithmetic {
	/// *Divisbility*: when division by `divisor` results in a whole number.
	func divisible(by divisor: Self) -> Bool {
		return self % divisor == 0
	}
}

extension Sequence
where Iterator.Element: ExpressibleByIntegerLiteral & IntegerArithmetic {
	public var sum: Iterator.Element {
		return self.reduce(
			0,
			+
		)
	}
}
