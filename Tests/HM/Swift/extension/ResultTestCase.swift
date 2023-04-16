import HM
import XCTest

final class ResultTestCase: XCTestCase {
  func test_init_optionals() throws {
    typealias Result = Swift.Result<Int, AnyError>
    typealias OneOfTwo = HM.OneOfTwo<Int, AnyError>

    XCTAssertThrowsError(
      try Result(success: 1, failure: AnyError() as Optional)
    ) { error in
      XCTAssert(OneOfTwo.Error.both ~= error)
    }

    XCTAssertThrowsError(
      try Result(success: nil, failure: nil)
    ) { error in
      XCTAssert(OneOfTwo.Error.neither ~= error)
    }

    XCTAssertEqual(
      try Result(success: nil, failure: .init() as Optional),
      Result.failure(.init())
    )
  }

  func test_init_Optional_Failure() {
    let success: Never? = nil
    XCTAssertThrowsError(
      try Result(
        success: success,
        failure: Never?.UnwrapError()
      ).get()
    )
  }

  func test_init_getSuccess() throws {
    typealias Result = Swift.Result<String, Error>

    func get😼() -> String { "😼" }

    XCTAssertEqual(
      try Result(get😼()).get(),
      "😼"
    )

    XCTAssert(
      Result.failure ~= (try .init(AnyError().throw()))
    )

    XCTAssertThrowsError(
      try Swift.Result<String, [Error]>(AnyError().throw())
    )
  }

  func test_init_getSuccess_Array() throws {
    enum Error: Swift.Error {
      case bad, strongBad
    }

    func throwBad() throws {
      throw Error.bad
    }

    func throwsStrongBads() throws {
      throw [Error.strongBad, .strongBad]
    }

    XCTAssertEqual(
      try [throwBad, throwsStrongBads].map {
        try Result<_, [Error]>(groupingFailures: $0())
      }.flatMap { Mirror.associatedValue(of: $0)! as [Error] },

      [Error.bad,
        .strongBad, .strongBad
      ]
    )

    do {
      XCTAssertThrowsError(
        try Result<_, [AnyError]>(groupingFailures: throwsStrongBads())
      )
    }
  }

  func test_VerificationResult() {
    XCTAssert(
      Result<_, Error>.success as (_) -> _ ~= .init(failure: nil)
    )

    XCTAssert(
      Result.failure ~= .init(failure: AnyError())
    )
  }
}
