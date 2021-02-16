import HM
import XCTest

final class CollectionOfOneTestCase: XCTestCase {
  func test() {
    _ = 0 as CollectionOfOne<Int>
    _ = "⛳️" as CollectionOfOne<String>
  }
}
