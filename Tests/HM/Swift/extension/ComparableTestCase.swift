import HM
import XCTest

final class ComparableTestCase: XCTestCase {
  func test_clamped() {
    XCTAssertEqual("C".clamped(to: "F"..."P"), "F")
  }
}
