import HM
import XCTest

final class CurrentValueIteratorTestCase: XCTestCase {
  func test() {
    var iterator = CurrentValueIterator(0...1)
    XCTAssertEqual(iterator.value, 0)
    iterator.next()
    XCTAssertEqual(iterator.value, 1)
    iterator.next()
    XCTAssertNil(iterator.value)
  }
}
