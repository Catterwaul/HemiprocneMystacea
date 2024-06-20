import HM
import Thrappture
import XCTest

final class ThrowingPropertyWrapperTestCase: XCTestCase {
  func test_errorMapping() {
    Optional: do {
      let none: Never? = .none
      XCTAssertThrowsError(
        try none.wrappedValue() ?? AnyError().throw()
      ) { error in
        XCTAssert(error is AnyError)
      }
    }

    Result: do {
      let result = Result<Never, _>.failure(Never?.nil)
      XCTAssertThrowsError(
        try result.wrappedValue() ?? AnyError().throw()
      ) { error in
        XCTAssert(error is AnyError)
      }
    }
  }

  func test_coalescing() {
    Error: do {
      let value: Optional = "🪙"
      let none = nil as String?

      XCTAssertEqual(
        try none.wrappedValue() ?? value.wrappedValue(),
        value
      )

      XCTAssertThrowsError(
        try none.wrappedValue() ?? AnyError().throw()
      )
    }

    Result: do {
      typealias Result = Swift.Result<Bool, AnyError>
      let success = Result.success(true)
      let failure = Result.failure(.init())
      XCTAssertEqual(failure ?? failure ?? success, success)
    }

    GetMutatingSet: do {
      typealias Property = GetMutatingSet<Bool, AnyError>
      let success = Property { true }
      let failure = Property { () throws(AnyError) in .init() }
      XCTAssertTrue(try (failure ?? failure ?? success).wrappedValue())
    }
  }
}
