import HemiprocneMystacea
import XCTest

final class SequenceTypeTestCase: XCTestCase {
	func testForAll() {
		XCTAssertEqual([1, 2, 3] ∀ {$0 == 3}, false)
		XCTAssertEqual([1, 1, 1] ∀ {$0 == 1}, true)
	}
	
//MARK:- Unique Elements
	func testUniqueElements_Hashable() {
		XCTAssertEqual([1, 1, 1].uniqueElements, [1])
	}
	
	func testUniqueElements_Equatable() {
		let array = [
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 1)
		].uniqueElements
		XCTAssertEqual(array, [TypeWith1EquatableProperty(int: 1)])
	}
//MARK:-
	
	func testSum() {
		let sum = [1, 1, 1].sum
		XCTAssertEqual(sum, 3)
	}
}


//MARK:- For testUniqueElements_Equatable
private struct TypeWith1EquatableProperty: Equatable {
	let int: Int
}
private func == (left: TypeWith1EquatableProperty, right: TypeWith1EquatableProperty)
-> Bool {
	return left == (right, {$0.int})
}