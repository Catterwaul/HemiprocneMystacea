import HM
import XCTest

final class CGPointTestCase: XCTestCase {
	func test_divideByPoint() {
		XCTAssertEqual(
			CGPoint(x: 6, y: 10)
				/ CGPoint(x: 3, y: 8),
			CGPoint(x: 2, y: 1.25)
		)
	}
	
	func test_divideByFloat() {
		XCTAssertEqual(
			CGPoint(x: 6, y: 10) / 4,
			CGPoint(x: 1.5, y: 2.5)
		)
	}
}
