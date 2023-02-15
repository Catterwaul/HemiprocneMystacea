import HM
import HeapModule
import XCTest

final class HeapTestCase: XCTestCase {
  func test_sorted() {
    XCTAssertEqual(
      .init(Heap([1, 0, 2, 0]).sorted),
      [0, 0, 1, 2]
    )
  }
}
