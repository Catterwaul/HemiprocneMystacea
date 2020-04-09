import HM
import XCTest

final class OptionalTestCase: XCTestCase {
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
    XCTAssertThrowsError( try iterate(nil) )
  }
}
