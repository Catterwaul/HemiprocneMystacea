import HM
import XCTest

final class SortedArrayTestCase: XCTestCase {
	func test_init() {
		let array: SortedArray = [3, 2, 1]
		XCTAssertEqual(
			array.backingArray,
			[1, 2, 3]
		)
	}
}
