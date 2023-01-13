import HM
import XCTest

final class ResultTestCase: XCTestCase {
  func test_init_optionals() throws {
    typealias Result = Swift.Result<Int, AnyError>
    typealias OneOfTwo = HM.OneOfTwo<Int, AnyError>

    XCTAssertThrowsError(
      try Result(success: 1, failure: AnyError() as Optional)
    ) { error in
      guard case OneOfTwo.Error.both = error
      else { return XCTFail() }
    }

    XCTAssertThrowsError(
      try Result(success: nil, failure: nil)
    ) { error in
      guard case OneOfTwo.Error.neither = error
      else { return XCTFail() }
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
        failure: Optional<Never>.UnwrapError.nil
      ).get()
    )
  }

  func test_init_getSuccess() throws {
    typealias Result = Swift.Result<String, Error>

    func get😼() -> String { "😼" }

    guard case let .success(😼) = try Result(get😼())
    else { return XCTFail() }

    XCTAssertEqual(😼, "😼")

    XCTAssert(
      Result.failure ~= (try .init(AnyError.throw()))
    )

    XCTAssertThrowsError(
      try Swift.Result<String, [Error]>(AnyError.throw())
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
        try Result<Void, [Error]>(groupingFailures: $0())
      }.flatMap { Mirror.associatedValue(of: $0)! as [Error] },

      [Error.bad,
        .strongBad, .strongBad
      ]
    )

    do {
      XCTAssertThrowsError(
        try Result<Void, [AnyError]>(groupingFailures: throwsStrongBads())
      )
    }
  }

  func test_VerificationResult() {
    XCTAssert(
      Result<_, Error>.success as (()) -> _ ~= .init(failure: nil)
    )

    XCTAssert(
      Result.failure ~= .init(failure: AnyError())
    )
  }
}
