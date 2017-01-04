import HM
import XCTest

final class NamedSubscriptTestCase: XCTestCase {
	func test_NamedGetOnlySubscript() {
		let bodies = NamedGetOnlySubscript{
			(head: String) in [
				"🐯": "🐅",
				"🐷": "🐖",
				"🐮": "🐄",
				"🐔": "🐓",
				"🐰": "🐇"
			][head]
		}
		
		XCTAssertEqual(bodies["🐯"], "🐅")
		XCTAssertEqual(bodies["🐷"], "🐖")
		XCTAssertEqual(bodies["🐮"], "🐄")
		XCTAssertEqual(bodies["🐔"], "🐓")
		XCTAssertEqual(bodies["🐰"], "🐇")
	}
  
	func test_multipleIndices() {
		enum Fruit: String {
			case
				apple = "🍏",
				banana = "🍌",
				strawberry = "🍓"
		}
		
		let rawFruits = NamedGetOnlySubscript{
			(fruit: Fruit) in fruit.rawValue
		}
		
		XCTAssertEqual(
			rawFruits[.banana, .apple],
			["🍌", "🍏"]
		)
		
		let strawberryAppleAndBanana: [Fruit] = [
			.strawberry,
			.apple,
			.banana
		]
		XCTAssertEqual(
			rawFruits[strawberryAppleAndBanana],
			["🍓", "🍏", "🍌"]
		)
	}
}
