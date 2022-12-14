import HM
import XCTest

final class SIMDTestCase: XCTestCase {
  func test_negation() {
    XCTAssertEqual(-SIMD2(0, 1), [0, -1])
  }

  func test_closedRange() {
    XCTAssertEqual(
      Array(SIMD2(0, 2)...[-2, 3]),
      [[0, 2], [-1, 3], [-2, 3]]
    )
  }

  func test_convertFromInts() {
    let ints = (1, 1)
    XCTAssertEqual(
      SIMD2<Double>(ints.0, ints.1),
      .one
    )
  }

  func test_squareMagnitude() {
    XCTAssertEqual(SIMD2(2, 3).squareMagnitude, 13)
  }
}
