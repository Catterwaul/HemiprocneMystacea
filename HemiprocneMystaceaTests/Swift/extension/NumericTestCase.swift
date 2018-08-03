import HM
import XCTest

final class NumericTestCase: XCTestCase {
  func test_DivisionByZeroError() {
    let numerator = Int.random( in: .min...(.max) )
    let error = DivisionByZeroError(numerator: numerator)
    XCTAssertEqual(error.numerator, numerator)
  }
}
