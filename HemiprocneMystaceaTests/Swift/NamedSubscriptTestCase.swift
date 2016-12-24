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
}
