import HM
import Algorithms
import XCTest

final class BidirectionalCollectionTestCase: XCTestCase {
  func test_suffix() {
    XCTAssertEqual("chunky skunky".suffix(from: "s"), "skunky")
    XCTAssertNil("aaabbbccc".suffix(from: "z"))
  }

  func test_firstDuplicate() {
    XCTAssertEqual(
      chain(1...5, [4, 3, 0]).firstDuplicate?.element,
      3
    )
  }
}
