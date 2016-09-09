import Foundation

public extension Collection where Iterator.Element: MeasurementProtocol {
	var sum: Iterator.Element? {
		guard let zero = first?.zero
		else {return nil}
		
		return self.reduce(zero, +)
	}
}

public protocol MeasurementProtocol {
	static func + (_: Self, _: Self) -> Self

	var zero: Self {get}
}

extension Measurement: MeasurementProtocol {
	public var zero: Measurement {
		return Measurement(
			value: 0,
			unit: unit
		)
	}
}
