import simd
import HM
import XCTest

final class SIMDTestCase: XCTestCase {
  func test_subscript() {
    var double3 = SIMD3((10...12).map(Double.init))
    var double4 = SIMD4((1...4).map(Double.init))

    XCTAssertEqual(double3[], [10, 11] as SIMD2)
    XCTAssertEqual(double4[], [1, 2, 3] as SIMD3)

    double4[] += double3
    XCTAssertEqual(double4, [11, 13, 15, 4])

    double3[] += [0, 1] as SIMD2
    XCTAssertEqual(double3, [10, 12, 12])

    double3[1, 2] = [-1, -2]
    XCTAssertEqual(double3, [10, -1, -2])
  }

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

  func test_matrix_init() {
    XCTAssertEqual(
      matrix_float3x3(column: [1, 2, 3], row: [2, 3, 4]),
      .init(columns: ([2, 4, 6], [3, 6, 9], [4, 8, 12]))
    )
  }
}
