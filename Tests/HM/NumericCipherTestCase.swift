import HM
import XCTest

final class NumericCipherTestCase: XCTestCase {
  func test() {
    let array: [RomanNumeral] = [.m, .m, .m, .cd, .l, .v, .i]
    XCTAssertEqual([RomanNumeral](3456), array)
    XCTAssertEqual(String(array), "MMMCDLVI")
  }
}
