import HM
import simd
import XCTest

final class float4x4TestCase: XCTestCase {
  func test_conversion() {
    var matrix = double4x4()
    matrix.columns.0 = [1, 2, 3, 4]
    XCTAssertEqual(float4x4(matrix).columns.0, [1, 2, 3, 4])
  }
}
