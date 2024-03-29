import HM
import XCTest

final class FibonacciSequenceTestCase: XCTestCase {
  func test() {
    let first29: [Double] = [
      0, 1, 1, 2, 3, 5, 8, 13, 21, 34,
      55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181,
      6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811
    ]

    XCTAssertEqual(
      Double.fibonacciSequence().prefix(29).map { $0 },
      first29
    )

    XCTAssertEqual(CGFloat.fibonacciSequence().makeIterator()[25], 75025)
  }
}
