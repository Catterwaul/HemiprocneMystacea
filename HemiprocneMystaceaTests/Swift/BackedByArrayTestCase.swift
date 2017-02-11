import HM
import XCTest

final class BackedByArrayTestCase: XCTestCase {
	let sortedArray = SortedArray(500, 100)
	
//MARK: Collection
	func test_subscript() {
		XCTAssertEqual(sortedArray[1], 500)
	}
	
	func test_endIndex() {
		XCTAssertEqual(sortedArray.endIndex, 2)
	}
	
	func test_startIndex() {
		XCTAssertEqual(sortedArray.startIndex, 0)
	}
	
	func test_indexAfter() {
		XCTAssertEqual(
			sortedArray.index(after: 0),
			1
		)
	}
}
