import HemiprocneMystacea
import XCTest

final class OperatorsTestCase: XCTestCase {
	func testBullet() {
		func string(int: Int) -> String {
			return String(int)
		}
		XCTAssertEqual(22•string, "22")
	}
	
	func testInitializationEllipsis() {
		class Class {
			var bool: Bool!
		}
		let `class` = Class()…{
			$0.bool = true
		}
		XCTAssertTrue(`class`.bool)
	}

	func testRecursionEllipsis() {
		struct Branch {
			let datum: Int
			let branches: [Branch]
		}
		
		let branch1 = Branch(
			datum: 1,
			branches: []
		)
		let branch2 = Branch(
			datum: 2,
			branches: [branch1]
		)
		let branch3 = Branch(
			datum: 3,
			branches: [
				branch2,
				branch1
			]
		)
		let branch4 = Branch(
			datum: 4,
			branches: [
				branch3,
				branch2,
				branch1
			]
		)
		
		XCTAssertEqual(
			([branch1,
				branch2,
				branch3,
				branch4
			]…{$0.branches})
			.map{$0.datum},
			[ 1,
				2,
					1,
				3,
					2,
						1,
					1,
				4,
					3,
						2,
							1,
						1,
					2,
						1,
					1
			]
		)
	}
}