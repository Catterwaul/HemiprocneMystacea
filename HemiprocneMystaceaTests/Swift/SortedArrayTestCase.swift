import HM
import XCTest

final class SortedArrayTestCase: XCTestCase {
	func test_init() {
		let array: SortedArray = [3, 2, 1]
		XCTAssertTrue(array == [1, 2, 3])
	}
	
	func test_add() {
		var array: SortedArray = [5, 4, 1, 3] + [2]
		
		XCTAssertTrue(array == [1, 2, 3, 4, 5])
		
		array += [-5, -10]
		XCTAssertTrue(
			array == [-10, -5, 1, 2, 3, 4, 5]
		)
	}
	
	func test_minAndMax() {
		let numbers: SortedArray = [
			104,
			33,
			-84,
			3
		]
		XCTAssertEqual(numbers.min(), -84)
		XCTAssertEqual(numbers.max(), 104)
		
		let strings: SortedArray = [
			"Meow 😺",
			"Chow 🥘",
			"Blow 🌬"
		]
		XCTAssertEqual(strings.min(), "Blow 🌬")
		XCTAssertEqual(strings.max(), "Meow 😺")
	}

	func test_remove() {
		var array = [5, 4, 1, 3] as SortedArray - 4
		
		XCTAssertTrue(array == [1, 3, 5])

		array -= 3
		XCTAssertTrue(array == [1, 5])
	}
}
