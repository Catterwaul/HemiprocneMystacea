import HemiprocneMystacea
import XCTest

final class JSONTestCase: XCTestCase {
	func testJSON() {
		let
		oldKey = "🗝",
		jSON = JSON([oldKey: "🔑"])
		
		XCTAssertEqual(
			try jSON.`subscript`(oldKey),
			"🔑"
		)
		
		let turKey = "🦃"
		XCTAssertThrowsError(
			try jSON.`subscript`(turKey) as Any
		){error in
			switch error {
			case JSON.Error.noValue(let key):
				XCTAssertEqual(key, turKey)
			default: XCTFail()
			}
		}
		
		XCTAssertThrowsError(
			try jSON.`subscript`(oldKey) as Bool
		){error in
			switch error {
			case JSON.Error.typeCastFailure(let key):
				XCTAssertEqual(oldKey, key)
			default: XCTFail()
			}
		}
	}
}
