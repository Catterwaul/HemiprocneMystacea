import HM
import XCTest

final class CollectionTestCase: XCTestCase {
// MARK: - Subscripts

  func test_subscript_indexSequence() {
    XCTAssertEqual(
      Array(["🐰", "🌞", "🎃", "🎅"][stride(from: 1, to: 4, by: 2)]),
      ["🌞", "🎅"]
    )
  }

  func test_subscript_modulo() {
    let ints = [1, 2]
    for (index, int) in [
      (0, 1), (1, 2),
      (2, 1), (3, 2),
      (-1, 2), (-2, 1),
      (-3, 2), (-4, 1)
    ] {
      XCTAssertEqual(ints[cycling: index], int)
    }
    
    XCTAssertEqual(
      "abc"["c", moduloOffset: 1],
      "a"
    )
  }

  func test_subscript_startOffsetBy() {
    XCTAssertEqual("🎤🐈"[startIndexOffsetBy: 1], "🐈")
  }

  func test_subscript_validating() {
    XCTAssertThrowsError(try ["🐾", "🥝"][validating: 2])
    
    let collection = Array(1...10)
    XCTAssertEqual(try collection[validating: 0], 1)
    XCTAssertThrowsError(try collection[validating: collection.endIndex]) {
      XCTAssert($0 is Array<Int>.IndexingError)
    }
  }

// MARK: - Methods

  func test_chunks() {
    XCTAssertEqual(
      (1...6).chunks(totalCount: 3).map(Array.init),
      [[1, 2], [3, 4], [5, 6]]
    )

    XCTAssertEqual(
      (1...7).chunks(totalCount: 2).map(Array.init),
      [[1, 2, 3], [4, 5, 6, 7]]
    )
  }

  func test_prefix() {
    XCTAssertEqual(
      "glorb14prawn".prefix(upTo: "1"),
      "glorb"
    )
    
    XCTAssertEqual(
      "glorb14prawn".prefix(through: "1"),
      "glorb1"
    )

    XCTAssertNil("boogalawncare".prefix(upTo: "z"))
    XCTAssertNil("boogalawncare".prefix(through: "z"))
  }

  @available(
    swift, deprecated: 6,
    message: "Won't compile without the `shifted` constant"
  )
  func test_shifted() {
    let shifted = stride(from: 0, through: 3, by: 1).shifted(by: 1)
    XCTAssertEqual(
      Array(shifted),
      [1, 2, 3, 0]
    )

    XCTAssertEqual(
      Array([0, 1, 2, 3].shifted(by: -1)),
      [3, 0, 1, 2]
    )
  }
}
