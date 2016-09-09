import Foundation

public extension Sequence where Iterator.Element: SummableUsingInstanceZero {
	var sum: Iterator.Element? {
		guard let zero = first?.zero
		else {return nil}
		
		return self.reduce(zero, +)
	}
}

public protocol SummableUsingInstanceZero {
	static func + (_: Self, _: Self) -> Self

	var zero: Self {get}
}

extension Measurement: SummableUsingInstanceZero {
	public var zero: Measurement {
		return Measurement(
			value: 0,
			unit: unit
		)
	}
}
