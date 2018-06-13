import HM
import XCTest

final class SequenceTestCase: XCTestCase {
	func test_containsOnly() {
		let ones = [1, 1, 1]
		let oneTwoThree = [1, 2, 3]
		
		XCTAssertTrue( ones.containsOnly(1) )
		XCTAssertFalse( oneTwoThree.containsOnly(2) )
		
		XCTAssertTrue(ones.containsOnly {$0 == 1})
		XCTAssertFalse(oneTwoThree.containsOnly {$0 == 3})
	}
	
	func test_max() {
		XCTAssertEqual(
			[	"1️⃣": 1,
				"🔟": 10,
			 	"💯": 100
			].max {$0.value}!
			 .key,
			"💯"
		)
	}
	
	func test_sortedBy() {
		let sortedArray = [
			TypeWith1EquatableProperty(int: 3),
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 2)
		].sorted {$0.int}
		
		XCTAssertEqual(
			sortedArray,
			[ TypeWith1EquatableProperty(int: 1),
			  TypeWith1EquatableProperty(int: 2),
			  TypeWith1EquatableProperty(int: 3)
			]
		)
	}
	
	func test_sum() {
		XCTAssertEqual(
      [1, 1, 1].sum,
      3
    )
	}
	
//MARK: uniqueElements
	func test_uniqueElements_Hashable() {
		XCTAssertEqual(
			[1, 1, 1].uniqueElements,
			[1]
		)
	}
	
	func test_uniqueElements_Equatable() {
		let uniqueArray = [
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 1)
		].uniqueElements
		XCTAssertEqual(
			uniqueArray,
			[TypeWith1EquatableProperty(int: 1)]
		)
	}
}

private struct TypeWith1EquatableProperty: Equatable {
	let int: Int
}
