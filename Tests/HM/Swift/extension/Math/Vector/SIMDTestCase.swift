import HM
import XCTest

final class SIMDTestCase: XCTestCase {
  func test_convertFromInts() {
    let ints = (1, 1)
    XCTAssertEqual(
      SIMD2<Double>(ints.0, ints.1),
      .one
    )
  }
}
