import HM
import XCTest

final class SetTestCase: XCTestCase {
	func test_insert() {
		var set: Set = [1, 2]
		
		set += 3
		
		XCTAssertEqual(
			set,
			[	1,
				2,
				3
			]
		)
	}
	
	func test_remove() {
		var set: Set = [1, 2]
		
		set -= 1
		set -= 3
		
		XCTAssertEqual(set, [2])
	}
	
	func test_intersect() {
		let set: Set = [
			1,
			2,
			3
		] ∩ [
			2,
			3,
			4,
			785723948
		]
		
		XCTAssertEqual(
			set,
			[2, 3]
		)
	}
	
	func test_union() {
		let set: Set = [
			0,
			1,
			2,
			3
		] ∪ [
			2,
			3,
			4,
			5,
			6
		]
		XCTAssertEqual(
			set,
			[	0,
				1,
				2,
				3,
				4,
				5,
				6
			]
		)
	}
}
