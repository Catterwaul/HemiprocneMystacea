import HM
import XCTest

final class HashableViaIDTestCase: XCTestCase {
  func test() {
    struct S: HashableViaID {
      let id: String
    }

    XCTAssertEqual(S(id: "🆔"), S(id: "🆔"))
    XCTAssertNotEqual(S(id: "🆔"), S(id: "💡"))
  }
}
