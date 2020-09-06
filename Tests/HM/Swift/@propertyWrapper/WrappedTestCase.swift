import HM
import XCTest

final class WrappedTestCase: XCTestCase {
  func test_callAsFunction() {
    XCTAssertEqual(
      Struct().$cat { "🏃 \($0)" },
      .snackTimeIllustration
    )

    var cat = Struct().$cat
    cat { $0 = "🐆" }
    XCTAssertEqual(cat.wrappedValue, "🐆")
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
      Wrapped("🐈")
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