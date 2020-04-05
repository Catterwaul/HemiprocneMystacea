import HM
import XCTest

final class BinaryIntegerTestCase: XCTestCase {
  func test_init_bitPattern() {
    XCTAssertEqual(
      Int(bitPattern: [true, false, true, false]),
      0b1010
    )
  }

  func test_masked() {
    XCTAssertEqual(
      0b11_10_1110.masked(upperBitIndex: 3),
      0b0_____1110
    )

    XCTAssertEqual(
      UInt8(0b11_1011_10).masked(lowerBitIndex: 2, upperBitIndex: 5),
            0b0__1011 << 2
    )

    XCTAssertEqual(
      1.masked(upperBitIndex: 0),
      1
    )
  }

  func test_factorial() {
    XCTAssertNil( (-4).factorial )
    XCTAssertEqual(0.factorial, 1)
    XCTAssertEqual(4.factorial, 24)
  }
}