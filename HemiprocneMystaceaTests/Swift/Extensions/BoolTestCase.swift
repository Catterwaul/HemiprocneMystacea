import HM
import XCTest

final class BoolTestCase: XCTestCase {
	func testInitWithBinaryString() {		
		XCTAssertFalse(
			Bool(binaryString: "0")!
		)
		XCTAssertTrue(
			Bool(binaryString: "1")!
		)
		
		XCTAssertNil(
			Bool(binaryString: "-1")
		)
		XCTAssertNil(
			Bool(binaryString: "2")
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
