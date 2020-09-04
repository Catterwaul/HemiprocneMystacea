import HM
import XCTest

final class OptionalTestCase: XCTestCase {
  func test_init_optionals() throws {
    var jenies: (String?, String?) = ("👖", "🧞‍♂️")

    do {
      let jenies = try XCTUnwrap( .init(optionals: jenies) )
      XCTAssert( jenies == ("👖", "🧞‍♂️") )
    }

    jenies.1 = nil
    XCTAssertNil( Optional(optionals: jenies) )
  }

  func test_reduce() {
    var int: Int? = nil
    XCTAssertEqual(int.reduce(1, +), 1)

    int = 2
    XCTAssertEqual(int.reduce(1, +), 3)


    var optionalArray: [Int]? = nil
    let array: [Int] = [1, 2]

    XCTAssertEqual(
      optionalArray.reduce(array) { $1 + $0 },
      array
    )

    optionalArray = [0]
    XCTAssertEqual(
      optionalArray.reduce(array) { $1 + $0 },
      [0, 1, 2]
    )
  }

  func test_unwrap() {
    func iterate(_ array: Any?...) throws {
      try array.forEach { _ = try $0.unwrap() }
    }

    XCTAssertNoThrow( try iterate() )
    XCTAssertThrowsError(try iterate(nil)) { error in
      guard error is Optional<Any>.UnwrapError
      else { XCTFail(); return }
    }
  }
}
