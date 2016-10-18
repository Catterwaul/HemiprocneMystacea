import HM
import XCTest

final class IntegersTestCase: XCTestCase {
	func test_divisible() {
		XCTAssertTrue(
			4.divisible(by: 2)
		)
		XCTAssertFalse(
			33.divisible(by: 8)
		)
	}
}
