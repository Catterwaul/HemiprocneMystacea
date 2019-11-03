import Foundation
import HM
import XCTest

final class MeasurementTestCase: XCTestCase {
  func test_AdditiveArithmetic_conformance() {
    for unit in [
      UnitSpeed.kilometersPerHour, .knots, .metersPerSecond, .milesPerHour
    ] {
      XCTAssertEqual(
        .zero,
        Measurement(value: 0, unit: unit)
      )
    }
  }

//MARK: sum
  func test_UnitMass_sum() {
    XCTAssertEqual(
      [	Measurement(value: 1, unit: UnitMass.grams),
         Measurement(value: 2, unit: .grams)
      ].sum,
      Measurement(value: 3, unit: .grams)
    )
  }

  func test_UnitSpeed_sum() {
    XCTAssertNil(
      ([] as [Measurement<UnitSpeed>]).sum
    )
  }
	
  func test_UnitVolume_sum() {
    XCTAssertEqual(
      [ Measurement(value: 1, unit: UnitVolume.milliliters),
        Measurement(value: 222, unit: .milliliters)
      ].sum,
      Measurement(value: 0.223, unit: .liters)
    )
  }
}
