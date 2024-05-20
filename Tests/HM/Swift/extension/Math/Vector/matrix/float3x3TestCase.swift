import HM
import simd
import XCTest

final class float3x3TestCase: XCTestCase {
  func test_conversion() {
    var matrix = double3x3()
    matrix.columns.0 = [1, 2, 3]
    XCTAssertEqual(float3x3(matrix).columns.0, [1, 2, 3])
  }
}
