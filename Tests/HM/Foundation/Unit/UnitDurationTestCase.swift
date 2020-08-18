import Foundation
import HM
import XCTest

final class UnitDurationTestCase: XCTestCase {
  func test() {
    XCTAssertEqual(
      Measurement(value: 1, unit: UnitDuration.weeks).baseValue,
      7 * 24 * 60 * 60
    )
  }
}
