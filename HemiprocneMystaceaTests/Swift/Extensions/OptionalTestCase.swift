import HM
import XCTest

final class OptionalTestCase: XCTestCase {
  func testAssignedIfNil() {
    var bool: Bool? = nil
    XCTAssertTrue(bool.assignedIfNil{true})
    XCTAssertTrue(bool.assignedIfNil{false})
  }
}
