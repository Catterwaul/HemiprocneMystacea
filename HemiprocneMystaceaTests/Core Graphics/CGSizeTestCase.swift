import HM
import XCTest

final class CGSizeTestCase: XCTestCase {
	func test_initWithPoint() {
		XCTAssertEqual(
			CGSize(
				CGPoint(
					x: 5,
					y: 55
				)
			),
			CGSize(
				width: 5,
				height: 55
			)
		)
	}
	
	func test_subtraction() {
		XCTAssertEqual(
			CGSize(
				width: 60,
				height: -80
			) - CGSize(
				width: 50,
				height: -100
			),
			CGSize(
				width: 10,
				height: 20
			)
		)
	}
}
