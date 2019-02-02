import HM
import XCTest

final class IntegersTestCase: XCTestCase {
	func test_divisible() {
		XCTAssertTrue( 4.divisible(divisor: 2) )
		XCTAssertFalse( 33.divisible(divisor: 8) )
	}

  func test_factorial() {
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
