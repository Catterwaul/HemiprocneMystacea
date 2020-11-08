import HM
import XCTest

final class FloatingPointTestCase: XCTestCase {
  func test_isInteger() {
    XCTAssert(1.0.isInteger)
    XCTAssertFalse((1.1 as CGFloat).isInteger)
  }
}
