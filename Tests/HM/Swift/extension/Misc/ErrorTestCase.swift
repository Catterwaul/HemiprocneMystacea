import HM
import XCTest

final class ErrorTestCase: XCTestCase {
  func test_AnyError() {
    XCTAssertEqual(
      AnyError(),
      AnyError { throw AnyError() }
    )

    XCTAssertNil(AnyError {})
  }

  func test_doCatch() {
    struct Error: Swift.Error {
      let property = "😫"
    }

    do {
      let result: Result<_, Error> = .success(true)

      guard let success = `do`(
        result.get,
        catch: { _ in XCTFail() }
      ) else { return }
      
      XCTAssertTrue(success)
    }

    do {
      let result: Result<_, Error> = .success(true)
      XCTAssertTrue(try `do`(result.get) { _ in  })
    }

    do {
      let result: Result<Void, _> = .failure(Error())

      guard let _ = result.get({ XCTAssert($0.property == "😫") })
      else { return }

      XCTFail()
    }
  }
}
