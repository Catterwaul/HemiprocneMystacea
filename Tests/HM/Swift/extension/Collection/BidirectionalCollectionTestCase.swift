import HM
import Algorithms
import XCTest

final class BidirectionalCollectionTestCase: XCTestCase {
  func test_last() {
    var array = [1]
    array.last_set? += 1
    XCTAssertEqual(array.last, 2)
    array.last_set = nil
    array.last_set = nil
    XCTAssert(array.isEmpty)
    array.last_set = 0
    XCTAssertEqual(array, [0])
  }

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
