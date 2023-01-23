import XCTest

final class DefaultStringInterpolationTestCase: XCTestCase {
  func test_appendInterpolation_String() {
    XCTAssertEqual(
      "string: \(.🧵) & \(.🧶)",
      "string: 🧵 & 🧶"
    )
  }
}

fileprivate extension String {
  static let 🧵 = "🧵"
  static let 🧶 = "🧶"
}
