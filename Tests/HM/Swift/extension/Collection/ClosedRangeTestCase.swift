import HM
import XCTest

final class ClosedRangeTestCase: XCTestCase {
  func test_🏓() {
    XCTAssertEqual(
      (2...10).🏓().map(Array.init),
      [6, 7, 5, 8, 4, 9, 3, 10, 2]
    )

    XCTAssertEqual(
      (2...10).🏓(startingAt: 7).map(Array.init),
      [7, 8, 6, 9, 5, 10, 4, 3, 2]
    )

    XCTAssertEqual(
      (-1.5...7.5).🏓(by: 1.5).map(Array.init),
      [3, 4.5, 1.5, 6, 0, 7.5, -1.5]
    )

    XCTAssertEqual(
      (0...6).🏓(by: -1).map(Array.init),
      [3, 2, 4, 1, 5, 0, 6]
    )

    XCTAssertNil( (0...3).🏓(startingAt: 4) )
  }
}
