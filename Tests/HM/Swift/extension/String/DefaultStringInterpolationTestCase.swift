import XCTest

final class DefaultStringInterpolationTestCase: XCTestCase {
  func test_appendInterpolation_String() {
    XCTAssertEqual(
      "string: \(.🧵) & \(.🧶)",
      "string: 🧵 & 🧶"
    )
  }
}

private extension String {
  static let 🧵 = "🧵"
  static let 🧶 = "🧶"
}
