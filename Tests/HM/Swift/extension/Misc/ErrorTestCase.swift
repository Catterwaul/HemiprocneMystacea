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

      guard let success = try? `do`(
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

      XCTAssertThrowsError(
        try result.get { XCTAssert($0.property == "😫") }
      )
    }

    do {
      let result: Result<String, _> = .failure(Error())
      XCTAssertEqual(
        `do` {
          try result.get()
        } catch: {
          ($0 as! Error).property
        },
        "😫"
      )
    }
  }

  func test_map() async {
    do {
      try await { try await AnyError().throw() as Void } ?! AnyError()
      XCTFail()
    } catch { }
  }
}
