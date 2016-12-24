import HM
import XCTest

final class JSONTestCase: XCTestCase {
	func test_JSON() {
		let
		oldKey = "🗝",
		json = JSON(object: [oldKey: "🔑"])
		
		XCTAssertEqual(
			try json.getValue(key: oldKey),
			"🔑"
		)
		
		let turKey = "🦃"
		XCTAssertThrowsError(
			try json.getValue(key: turKey) as Any
		){	error in
            
			switch error {
			case JSON.Error.noValue(let key):
				XCTAssertEqual(key, turKey)
			default: XCTFail()
			}
		}
		
		XCTAssertThrowsError(
			try json.getValue(key: oldKey) as Bool
		){  error in
            
			switch error {
			case JSON.Error.typeCastFailure(let key):
				XCTAssertEqual(key, oldKey)
			default: XCTFail()
			}
		}
	}
	
	func test_InitializableWithJSONArray_init() {
		struct Instrument: InitializableWithJSON {
			init(json: JSON) {
				visualization = try! json.getValue(key: "visualization")
			}
			
			let visualization: String
		}
		
		let jSObject = [
			"instruments": [
				["visualization": "🎹"],
				["visualization": "🎸"],
				["visualization": "🎷"]
			]
		]
		
		let instruments = try! [Instrument](
			json: JSON(object: jSObject),
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
				json: JSON(object: jSObject),
				key: turKeyboard
			)
		){ error in
            
			switch error {
			case JSON.Error.noValue(let key):
				XCTAssertEqual(key, turKeyboard)
			default: XCTFail()
			}
		}
	}
}
