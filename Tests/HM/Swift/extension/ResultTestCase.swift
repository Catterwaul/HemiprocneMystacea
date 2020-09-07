import HM
import XCTest

final class ResultTestCase: XCTestCase {
  func test_init_optionals() throws {
    struct Error: Swift.Error, Equatable { }
    typealias Result = Swift.Result<Int, Error>
    typealias OneOfTwo = HM.OneOfTwo<Int, Error>

    XCTAssertThrowsError(
      try Result( success: 1, failure: .init() as Optional )
    ) { error in
      guard case OneOfTwo.Error.both = error
      else { XCTFail(); return }
    }

    XCTAssertThrowsError(
      try Result(success: nil, failure: nil)
    ) { error in
      guard case OneOfTwo.Error.neither = error
      else { XCTFail(); return }
    }

    XCTAssertEqual(
      try Result( success: nil, failure: .init() as Optional ),
      Result.failure( .init() )
    )
  }

  func test_init_Optional_Failure() {
    let success: Never? = nil
    XCTAssertThrowsError(
      try Result(
        success: success,
        failure: Optional<Never>.UnwrapError()
      ).get()
    )
  }

  func test_init_getSuccess() throws {
    typealias Result = Swift.Result<String, Error>

    func get😼() -> String { "😼" }
    struct Error: Swift.Error { }

    guard case let .success(😼)
      = try Result( get😼() )
    else { XCTFail(); return }

    XCTAssertEqual(😼, "😼")

    func throwError() throws -> String {
      throw Error()
    }

    XCTAssert(
      Result.failure ~= ( try .init( throwError() ) )
    )

    XCTAssertThrowsError(
      try Swift.Result<String, [Error]>( throwError() )
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
        try Result<Void, [Error]>(groupingFailures: $0() )
      }.flatMap { Mirror.associatedValue(of: $0)! as [Error] },

      [ Error.bad,
        .strongBad, .strongBad
      ]
    )

    do {
      enum Error: Swift.Error { }

      XCTAssertThrowsError(
        try Result<Void, [Error]>( groupingFailures: throwsStrongBads() )
      )
    }
  }

  func test_VerificationResult() {
    struct Error: Swift.Error { }

    XCTAssert(
      VerificationResult<Error>.success ~= .init(failure: nil )
    )

    XCTAssert(
      VerificationResult.failure ~= .init(failure: Error() )
    )
  }
}
