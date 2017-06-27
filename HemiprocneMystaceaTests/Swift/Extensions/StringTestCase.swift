import HM
import XCTest

final class StringTestCase: XCTestCase {
	func test_after() {
		XCTAssertEqual(
			"chunky skunky".after("s"),
			"kunky"
		)
		XCTAssertNil(
			"aaabbbccc".after("z")
		)
	}
	
	func test_upTo() {
		XCTAssertEqual(
			"glorb14prawn".upTo("1"),
			"glorb"
		)
		
		XCTAssertEqual(
			"glorb14prawn".upTo(
				"1",
				characterIsIncluded: true
			),
			"glorb1"
		)
		
		XCTAssertNil(
			"boogalawncare".upTo("z")
		)
	}
	
	func test_without() {
		let rabbitsAndEars = "👯🐇🐰👂🌽"
		
		XCTAssertNil(
			rabbitsAndEars.without(prefix: "🐰")
		)
		
		XCTAssertEqual(
			rabbitsAndEars.without(prefix: "👯🐇"),
			"🐰👂🌽"
		)
		
		XCTAssertNil(
			rabbitsAndEars.without(suffix: "🐰")
		)
		
		XCTAssertEqual(
			rabbitsAndEars.without(suffix: "🌽"),
			"👯🐇🐰👂"
		)
	}
	
//MARK: Operators
	func test_minus() {
		XCTAssertEqual(
			" 123🐉Boodee Bop! 123🐉" - " 123🐉",
			"Boodee Bop!"
		)
	}
	
	func test_minusWithSequence() {
		XCTAssertEqual(
			" 123🐉Boodee Bop! 123🐉" - [" 123🐉", "Bo"],
			"odee p!"
		)
	}
}
