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
}
