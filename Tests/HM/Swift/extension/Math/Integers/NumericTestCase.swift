import HM
import XCTest

final class NumericTestCase: XCTestCase {
  func test_DivisionByZeroError() {
    let numerator = Int.random( in: .min...(.max) )
    let error = DivisionByZeroError(numerator: numerator)
    XCTAssertEqual(error.numerator, numerator)
  }

  func test_squared() {
    let intMaxSquareRoot = Int( Double(Int.max).squareRoot() )
    let int = Int.random(in: -intMaxSquareRoot...intMaxSquareRoot)
    XCTAssertEqual(int.squared, int * int)

    let doubleMaxSquareRoot = Double.greatestFiniteMagnitude.squareRoot()
    let double = Double.random( in: -doubleMaxSquareRoot...doubleMaxSquareRoot)
    XCTAssertEqual(double.squared, double * double)
  }
}
