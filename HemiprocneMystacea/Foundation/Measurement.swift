import Foundation

public extension Sequence where Iterator.Element: MeasurementProtocol {
	var sum: Self {
		let zero = Iterator.Element.init(
			value: 0,
			unit: unit
		)
		
		return self.reduce(zero, +)
	}
}

public protocol MeasurementProtocol {
	associatedtype UnitType: Unit
	
	static func + (_: Self, _: Self) -> Self
	
	init(value: Double, unit: UnitType)
	
	var unit: UnitType {get}
}

extension Measurement: MeasurementProtocol {}
