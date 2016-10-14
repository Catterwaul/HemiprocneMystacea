import HM
import XCTest

final class SequenceTestCase: XCTestCase {
	func testContainsOnly() {
		let
		ones = [
			1,
			1,
			1
		],
		oneTwoThree = [
			1,
			2,
			3
		]
		
		XCTAssertTrue(ones.containsOnly(1))
		XCTAssertFalse(oneTwoThree.containsOnly(2))
		
		XCTAssertTrue(ones.containsOnly{$0 == 1})
		XCTAssertFalse(oneTwoThree.containsOnly{$0 == 3})
	}

	func testFirst() {
		XCTAssertEqual(
			[	1,
				5,
				3
			].first{$0 == 5},
			5
		)
	}
	
	func testGrouped() {
		let objects = [
			("🔫", "💚"),
			
			("🎎", "💕"),
			("🎎", "💕"),
			
			("👩‍❤️‍💋‍👩", "💤"),
			("👩‍❤️‍💋‍👩", "💤"),
			("👩‍❤️‍💋‍👩", "💤")
		]
		
		let groups = objects.grouped{$0.0}
			.sorted{(key, objects) in objects.count}
			.map{
				(key, objects) in (
					key: key,
					objects.map{$0.1}
				)
			}
		
		XCTAssertEqual(groups[0].key, "🔫")
		XCTAssertEqual(
			groups[0].1,
			["💚"]
		)
		
		XCTAssertEqual(groups[1].key, "🎎")
		XCTAssertEqual(
			groups[1].1,
			["💕", "💕"]
		)
		
		XCTAssertEqual(groups[2].key, "👩‍❤️‍💋‍👩")
		XCTAssertEqual(
			groups[2].1,
			["💤", "💤", "💤"]
		)
	}
	
	func testSortedBy() {
		let sortedArray = [
			TypeWith1EquatableProperty(int: 3),
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 2)
		]	.sorted{$0.int}
		
		XCTAssertEqual(
			sortedArray,
			[ TypeWith1EquatableProperty(int: 1),
				TypeWith1EquatableProperty(int: 2),
				TypeWith1EquatableProperty(int: 3)
			]
		)
	}
	
	func testSum() {
		let sum = [
			1,
			1,
			1
		]	.sum
		XCTAssertEqual(sum, 3)
	}
	
//MARK: Unique Elements
	func testUniqueElements_Hashable() {
		XCTAssertEqual(
			[	1,
				1,
				1
			].uniqueElements,
			[1]
		)
	}
	
	func testUniqueElements_Equatable() {
		let uniqueArray = [
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 1)
		]	.uniqueElements
		XCTAssertEqual(
			uniqueArray,
			[TypeWith1EquatableProperty(int: 1)]
		)
	}
}

//MARK:- testUniqueElements_Equatable
private struct TypeWith1EquatableProperty: Equatable {
	let int: Int
}
private func == (
	operand0: TypeWith1EquatableProperty,
	operand1: TypeWith1EquatableProperty
)
-> Bool {
	return operand0 == (operand1,
		{$0.int}
	)
}
