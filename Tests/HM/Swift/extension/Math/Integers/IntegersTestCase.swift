import HM
import XCTest

final class IntegersTestCase: XCTestCase {
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
  
  func test_joined() {
    XCTAssertEqual(
      [1, 2].joined(),
      12
    )
    
    XCTAssertEqual(
      [1, 0b10].joined(radix: 0b10),
      0b110
    )
    
    XCTAssertEqual(
      [1, 0x10].joined(radix: 0x10),
      0x110
    )
  }
}
