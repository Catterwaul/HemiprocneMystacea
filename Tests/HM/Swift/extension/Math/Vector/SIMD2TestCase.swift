import HM
import XCTest

final class SIMD2TestCase: XCTestCase {
  func test_definiteIntegral() {
    XCTAssertNil(([] as [SIMD2<Double>]).definiteIntegral)
    
    let arrayWithZero = [(0.0, 0.0)]
    XCTAssertEqual(arrayWithZero.definiteIntegral, 0)
    
    XCTAssertEqual((arrayWithZero + [(1, 1)]).definiteIntegral, 0.5)
    
    XCTAssertEqual([(0.0, -3.0), (4, 1)].definiteIntegral, -4)
  }

  func test_range() {
    XCTAssertEqual(
      Array(SIMD2(0, 2)..<[-2, 3]),
      [[0, 2], [-1, 3]]
    )
  }
}
