import HM
import XCTest

final class MatrixTestCase: XCTestCase {
  func test() {
    var matrix = Matrix(
      rows: [
        0...5,
        1...6
      ]
    )

    matrix.rows[1][2] = 100
    XCTAssertEqual(
      matrix.columns[2][1], 100
    )
  }
}
