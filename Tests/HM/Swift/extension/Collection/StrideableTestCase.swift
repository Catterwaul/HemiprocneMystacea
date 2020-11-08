import HM
import XCTest

final class StrideableTestCase: XCTestCase {
  func test_clamped() {
    let indices = [0, 1].indices
    XCTAssertEqual((-3).clamped(to: indices), 0)
    XCTAssertEqual(22.clamped(to: indices), 1)
  }
}
