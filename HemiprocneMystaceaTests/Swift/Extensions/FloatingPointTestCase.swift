import HM
import XCTest

final class FloatingPointTestCase: XCTestCase {
	func test_sum() {
		let sum = [
			1.0,
			2.0,
			3.0
		].sum
		
		XCTAssertEqual(sum, 6.0)
	}
}
