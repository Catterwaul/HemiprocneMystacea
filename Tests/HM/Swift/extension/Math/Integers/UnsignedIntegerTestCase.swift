import HM
import XCTest

final class UnsignedIntegerTestCase: XCTestCase {
  func test_digits() {
    XCTAssertEqual(
      (867_5309 as UInt).digits(),
      [8,6,7, 5,3,0,9]
    )
    XCTAssertEqual(
      (0x00_F0 as UInt).digits(radix: 0b10),
      [1,1,1,1, 0,0,0,0]
    )
    XCTAssertEqual(
      (0xA0_B1_C2_D3_E4_F5 as UInt).digits(radix: 0x10),
      [10,0, 11,1, 12,2, 13,3, 14,4, 15,5]
    )
    XCTAssertEqual(
      (0o00707 as UInt).digits(radix: 0o10),
      [0b111, 0, 0b111]
    )
  }
}
