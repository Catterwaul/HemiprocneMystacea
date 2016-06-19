import HemiprocneMystacea
import XCTest

final class JSONTestCase: XCTestCase {
	func testJSON() {
		let
		oldKey = "🗝",
		jSON = JSON([oldKey: "🔑"])
		
		XCTAssertEqual(
			try jSON.subscript(oldKey),
			"🔑"
		)
		
		let turKey = "🦃"
		XCTAssertThrowsError(
			try jSON.subscript(turKey) as Any
		){error in
			switch error {
			case JSON.Error.noValue(let key):
				XCTAssertEqual(key, turKey)
			default: XCTFail()
			}
		}
		
		XCTAssertThrowsError(
			try jSON.subscript(oldKey) as Bool
		){error in
			switch error {
			case JSON.Error.typeCastFailure(let key):
				XCTAssertEqual(key, oldKey)
			default: XCTFail()
			}
		}
	}
	
	func testInitializableWithJSONArray_init() {
		struct Instrument: InitializableWithJSON {
			init(jSON: JSON) {
				visualization = try! jSON.subscript("visualization")
			}
			
			let visualization: String
		}
		
		let jSON = [
			"instruments": [
				["visualization": "🎹"],
				["visualization": "🎸"],
				["visualization": "🎷"]
			]
		]
		
		let instruments = try! [Instrument](
			jSON: jSON,
			key: "instruments"
		)
		
		XCTAssertEqual(
			instruments.map{$0.visualization},
			[	"🎹",
				"🎸",
				"🎷"
			]
		)
		
		let turKeyboard = "🦃⌨️"
		XCTAssertThrowsError(
			try [Instrument](
				jSON: jSON,
				key: turKeyboard
			)
		){error in
			switch error {
			case JSON.Error.noValue(let key):
				XCTAssertEqual(key, turKeyboard)
			default: XCTFail()
			}
		}
	}
}
