import Foundation
import HM
import XCTest

final class MeasurementTestCase: XCTestCase {
//MARK: sum
	func test_UnitMass_sum() {
		XCTAssertEqual(
			[	Measurement(
					value: 1,
					unit: UnitMass.grams
				),
				Measurement(
					value: 2,
					unit: UnitMass.grams
				)
			].sum,
			Measurement(
				value: 3,
				unit: UnitMass.grams
			)
		)
	}
	
	func test_UnitVolume_sum() {
		XCTAssertEqual(
			[	Measurement(
					value: 1,
					unit: UnitVolume.milliliters
				),
			 	Measurement(
					value: 222,
					unit: UnitVolume.milliliters
				)
			].sum,
			Measurement(
				value: 0.223,
				unit: UnitVolume.liters
			)
		)
	}
}
