import HM
import XCTest

final class AnyObjectTestCase: XCTestCase {
  func test_identity() {
    final class 🍪 { }
    let c: 🍪? = 🍪()
    XCTAssert(c ==== c)
    XCTAssert(c !=== 🍪())
  }
}
