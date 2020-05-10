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

  func test_toThe() {
    XCTAssertEqual(3.toThe(3 as UInt), 27)
    XCTAssertEqual(1.toThe(4 as UInt), 1)
    XCTAssertEqual(0.toThe(5 as UInt), 0)
    XCTAssertEqual(0.toThe(0 as UInt), 1)
  }
}
