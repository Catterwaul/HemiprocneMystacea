import HM
import XCTest

final class MatrixTestCase: XCTestCase {
  func test() {
    var matrix = Matrix(
      rows: [
        0...2,
        1...3
      ]
    )

    matrix.rows[1][2] = 100

    XCTAssertEqual(
      Array(matrix),
      [ 0, 1, 2,
        1, 2, 100
      ]
    )

    XCTAssertEqual(
      matrix.orthogonalNeighbors([1, 1]),
      [[0, 1]: 1, [2, 1]: 100, [1, 0]: 1]
    )

    XCTAssertEqual(
      Array(matrix.indices),
      [ (0, 0), (1, 0), (2, 0),
        (0, 1), (1, 1), (2, 1)
      ].map(SIMD2.init)
    )

    XCTAssertEqual(
      matrix.description { $0.isMultiple(of: 2) ? "🌆" : "🅾️"  },
      """
      🌆🅾️🌆
      🅾️🌆🌆
      """
    )

    XCTAssertThrowsError(try matrix.validate([-1, -1]))
  }
}
