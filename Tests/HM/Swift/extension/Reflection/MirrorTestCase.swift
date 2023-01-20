import HM
import XCTest

final class MirrorTestCase: XCTestCase {
  func test_reflectsOptionalNone() {
    XCTAssert(Mirror(reflecting: Int?.none as Any).reflectsOptionalNone)
    XCTAssertFalse(Mirror(reflecting: "👓").reflectsOptionalNone)
  }
}
