import HM
import XCTest

final class AnySequenceTestCase: XCTestCase {
  func test_init_getNext() {
    XCTAssertEqual(
      AnySequence { "🧞" } .prefix(3).joined(),
      "🧞🧞🧞"
    )
  }
}
