import HM
import XCTest

final class FloatingPointTestCase: XCTestCase {
  func test_isInteger() {
    XCTAssert(1.0.isInteger)
    XCTAssertFalse((1.1 as CGFloat).isInteger)
  }

  func test_quantized() {
    XCTAssertEqual(Float16(0.16).rounded(toNearestMultipleOf: 1), 0)
    XCTAssertEqual(-4.9.rounded(toNearestMultipleOf: 2), -4)
    XCTAssertEqual(Float.pi.rounded(toNearestMultipleOf: 3), 3)
  }
}
