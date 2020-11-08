import HM
import XCTest

final class BidirectionalCollectionTestCase: XCTestCase {
  func test_suffix() {
    XCTAssertEqual("chunky skunky".suffix(from: "s"), "skunky")
    XCTAssertNil("aaabbbccc".suffix(from: "z"))
  }
}
