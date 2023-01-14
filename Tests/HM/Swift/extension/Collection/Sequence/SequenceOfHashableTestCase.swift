import HM
import XCTest

final class SequenceOfHashableTestCase: XCTestCase {
  func test_withKeyedIterations() {
    XCTAssert(
      "abccbaa".withKeyedIterations(of: 1...)
        ==
        [ ("a", 1), ("b", 1), ("c", 1),
          ("c", 2), ("b", 2), ("a", 2),
          ("a", 3)
        ]
    )
  }

  func test_filteringOutEarliestOccurrences() {
    XCTAssert(
      ["the", "people", "prefer", "to", "go", "to", "the", "sun", "beach"]
        .filteringOutEarliestOccurrences(
          from: ["the", "people", "prefer", "go", "to", "the", "moon", "beach"]
        )
        .elementsEqual(["to", "sun"])
    )
    
    XCTAssert(
      [1, 2, 3, 1]
        .filteringOutEarliestOccurrences(from: [2, 1, 2])
        .elementsEqual([3, 1])
    )
  }
}
