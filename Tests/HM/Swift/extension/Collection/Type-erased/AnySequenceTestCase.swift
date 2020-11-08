import HM
import XCTest

final class AnySequenceTestCase: XCTestCase {
  func test_init_getNext() {
    XCTAssertEqual(
      AnySequence { "🧞" } .prefix(3).joined(),
      "🧞🧞🧞"
    )
  }

  func test_zip() {
    XCTAssert(
      AnySequence(zip: (1...4, ["🦸🏻‍♀️", "🧟‍♀️"]))
      ==
      [(1, "🦸🏻‍♀️"), (2, "🧟‍♀️"), (3, nil), (4, nil)] as [(Int?, String?)]
    )
  }
}
