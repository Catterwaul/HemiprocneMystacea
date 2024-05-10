import HM
import XCTest

final class ErrorTestCase: XCTestCase {
  func test_coalesce() async {
    do {
      let `throw` = async { throw AnyError() }
      try await (try await `throw`()) ?? (try await `throw`())
      XCTFail()
    } catch { }
  }
}
