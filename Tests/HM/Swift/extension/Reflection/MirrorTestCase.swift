import HM
import XCTest

final class MirrorTestCase: XCTestCase {
  func test_reflectsOptionalNone() throws {
    XCTAssert(Mirror(reflecting: Int?.none as Any).reflectsOptionalNone)
    XCTAssertFalse(Mirror(reflecting: "👓").reflectsOptionalNone)
  }
}
