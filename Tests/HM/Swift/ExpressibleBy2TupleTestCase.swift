import HM
import XCTest

final class ExpressibleBy2TupleTestCase: XCTestCase {
  func test() {
    var components = URLComponents()
    components.queryItems = ["a": nil, "b": "2"]
    XCTAssertEqual(components.string, "?a&b=2")
  }
}
