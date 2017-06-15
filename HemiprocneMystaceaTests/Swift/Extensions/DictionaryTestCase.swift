import HM
import XCTest

final class DictionaryTestCase: XCTestCase {
//MARK: initializers
	func test_initWithSequenceAndTransform() {
		XCTAssertEqual(
			Dictionary(
				[ 1,
				  2,
				  3
				]
			){
				( key: $0,
				  value: String($0)
				)
			},
			[	1: "1",
			 	2: "2",
			 	3: "3"
			]
		)
	}
	func test_initWithVariadicAndTransform() {
		XCTAssertEqual(
			Dictionary(
				1,
				2,
				3
			){
				(	key: $0,
					value: String($0)
				)
			},
			[	1: "1",
			 	2: "2",
			 	3: "3"
			]
		)
	}
		
//MARK: Subscripts
	func test_optionalKeySubscript() {
		let
		dictionary = ["key": "value"],
		key: String? = "key",
		`nil`: String? = nil
		
		XCTAssertEqual(dictionary[key], "value")
		XCTAssertEqual(dictionary[`nil`], nil)
	}
	
	func test_valueAddedIfNilSubscript() {
		var dictionary = ["key": "value"]
		let valyoo = "valyoo"
		XCTAssertEqual(
			dictionary[
				"kee",
				valueAddedIfNil: valyoo
			],
			valyoo
		)
		XCTAssertEqual(
			dictionary,
			[	"key": "value",
				"kee": "valyoo"
			]
		)
	}

//MARK: Operators
	func test_plus() {
		let dictionary: [Int: Int] = [
			1: 10,
			2: 20
		] + [3: 30]
		XCTAssertEqual(
			dictionary + [
				3: 30,
				4: 40
			],
			[	1: 10,
				2: 20,
				3: 30,
				4: 40
			]
		)
	}
	
	func test_plusEquals() {
		var dictionary = [
			1: 10,
			2: 20
		]
		dictionary += [
			3: 30,
			4: 40
		]
		XCTAssertEqual(
			dictionary,
			[	1: 10,
				2: 20,
				3: 30,
				4: 40
			]
		)
	}
	
	func test_minus() {
		let dictionary = [
			1: 10,
			2: 20,
			3: 30
		]
		XCTAssertEqual(
			dictionary - [1, 3],
			[2: 20]
		)
	}
	
	func test_minusEquals() {
		var dictionary = [
			1: 10,
			2: 20,
			3: 30
		]
		dictionary -= [
			2: "🏩",
			1: "🤘🏽"
		].keys
		XCTAssertEqual(
			dictionary,
			[3: 30]
		)
	}
}
