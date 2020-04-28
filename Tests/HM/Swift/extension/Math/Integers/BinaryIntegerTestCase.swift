import HM
import XCTest

final class BinaryIntegerTestCase: XCTestCase {
  func test_init_bitPattern() {
    XCTAssertEqual(
      Int(bitPattern: [true, false, true, false]),
      0b1010
    )

    XCTAssertNil( Int(bitPattern: []) )
  }

  func test_masked() {
    XCTAssertEqual(
      0b11_10_1110[mask: ...3],
      0b0_____1110
    )

    XCTAssertEqual(
      UInt8(0b11_1011_10)[mask: 2...5],
            0b0__1011 << 2
    )

    XCTAssertEqual(
      1[mask: ...0],
      1
    )
  }

  func test_modulo() {
    XCTAssertEqual(1.modulo(2), 1 % 2)
    XCTAssertEqual( (-1).modulo(2), 1 )
  }

  func test_factorial() {
    XCTAssertNil( (-4).factorial )
    XCTAssertEqual(0.factorial, 1)
    XCTAssertEqual(4.factorial, 24)
  }
}
