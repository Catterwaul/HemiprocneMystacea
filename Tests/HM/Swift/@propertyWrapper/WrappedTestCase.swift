import HM
import XCTest

final class WrappedTestCase: XCTestCase {
  func test_callAsFunction() {
    XCTAssertEqual(
      Struct().$cat { "🏃 \($0)" },
      .snackTimeIllustration
    )
  }

  func test_if() {
    var isSnackTime = false
    XCTAssertEqual(
      Struct().$cat
        .if(isSnackTime) { "🏃 \($0)" },
      "🐈"
    )

    isSnackTime = true
    XCTAssertEqual(
      Wrapped(wrappedValue: "🐈")
        .if(isSnackTime) { "🏃 \($0)" },
      .snackTimeIllustration
    )
  }
}

private struct Struct {
  @Wrapped var cat = "🐈"
}

private extension String {
  static let snackTimeIllustration = "🏃 🐈"
}
