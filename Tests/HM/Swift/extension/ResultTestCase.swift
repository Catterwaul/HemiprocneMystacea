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
}
