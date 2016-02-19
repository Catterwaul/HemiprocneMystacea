import HemiprocneMystacea
import XCTest

final class SequenceTypeTestCase: XCTestCase {	
	func testFirst🔎() {
		XCTAssertEqual([1, 5, 3].first🔎{$0 == 5}, 5)
	}
   
   func testObeys() {
      XCTAssertEqual([1, 2, 3].obeys{$0 == 3}, false)
      XCTAssertEqual([1, 1, 1].obeys{$0 == 1}, true)
   }
   
	func testSortedBy() {
		let sortedArray = [
			TypeWith1EquatableProperty(int: 3),
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 2)
		].sorted{$0.int}
		XCTAssertEqual(
			sortedArray,
			[
				TypeWith1EquatableProperty(int: 1),
				TypeWith1EquatableProperty(int: 2),
				TypeWith1EquatableProperty(int: 3)
			]
		)
	}
	
//MARK:- Unique Elements
	func testUniqueElements_Hashable() {
		XCTAssertEqual([1, 1, 1].uniqueElements, [1])
	}
	
	func testUniqueElements_Equatable() {
		let uniqueArray = [
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 1)
		].uniqueElements
		XCTAssertEqual(uniqueArray, [TypeWith1EquatableProperty(int: 1)])
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