import HemiprocneMystacea
import XCTest

final class BoolTestCase: XCTestCase {
	func testInitWithString() {
		XCTAssertFalse(
			Bool("0")!
		)
		XCTAssertTrue(
			Bool("1")!
		)
		
		XCTAssertNil(
			Bool("-1")
		)
		XCTAssertNil(
			Bool("2")
		)
	}
	
	func testToggle() {
		var bool = false
		bool.toggle()
		XCTAssertTrue(bool)
	}
	
	//MARK:- Sequences of Bools
	func testContainsOnly() {
		let trueConditions = [
			{true},
			{1 < 2},
			{"🦁" == "🦁"}
		]
		XCTAssertTrue(
			trueConditions.containsOnly(true)
		)
		XCTAssertFalse(
			(trueConditions + [{false}]).containsOnly(true)
		)
	}
}