import HM
import XCTest

final class ClosedRangeTestCase: XCTestCase {
  func test_division() {
    XCTAssertEqual((10...100) / 10, 1...10)
  }

  func test_init_encompassing() {
    XCTAssertNil(ClosedRange(encompassing: [] as [Int]))
  }

  func test_subscript_normalized() {
    XCTAssertEqual(
      (-1...3)[normalized: 0.5],
      1
    )
  }

  func test_normalize() throws {
    XCTAssertEqual(
      ClosedRange(encompassing: [1.0, -10, 10])?.normalize(0),
      0.5
    )

    XCTAssertNil((1...1).normalize(1))
  }

  func test_🏓() {
    XCTAssertEqual(
      Array((2...10).🏓()),
      [6, 7, 5, 8, 4, 9, 3, 10, 2]
    )

    XCTAssertEqual(
      Array((2...10).🏓(startingAt: 7)),
      [7, 8, 6, 9, 5, 10, 4, 3, 2]
    )

    XCTAssertEqual(
      Array((-1.5...7.5).🏓(by: 1.5)),
      [3, 4.5, 1.5, 6, 0, 7.5, -1.5]
    )

    XCTAssertEqual(
      Array((0...6).🏓(by: -1)),
      [3, 2, 4, 1, 5, 0, 6]
    )

    XCTAssertEqual(
      Array((0...3).🏓(startingAt: 4)),
      []
    )
  }
}
