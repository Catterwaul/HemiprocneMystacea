import HM
import XCTest

final class JSONTestCase: XCTestCase {
	func test_JSON() {
		let
			oldKey = "🗝",
			json = try! JSON(dictionary: [oldKey: "🔑"])
		
		XCTAssertEqual(
			try json.getValue(key: oldKey),
			"🔑"
		)
		
		let turKey = "🦃"
		XCTAssertThrowsError(
			try json.getValue(key: turKey) as Any
		){	error in switch error {
         case SerializableDictionaryError.noValue(let key):
            XCTAssertEqual(key, turKey)
				
			default: XCTFail()
			}
		}
		
		XCTAssertThrowsError(
			try json.getValue(key: oldKey) as Bool
		){ error in switch error {
         case SerializableDictionaryError.typeCastFailure(let key):
				XCTAssertEqual(key, oldKey)
				
			default: XCTFail()
			}
		}
	}
	
	func test_InitializableWithJSONArray_init() {
		struct Instrument: InitializableWithSerializableDictionary {
         init<Dictionary: SerializableDictionary>(
            dictionary: Dictionary
         ) {
				visualization = try! dictionary.getValue(key: "visualization")
			}
			
			let visualization: String
		}
		
		let dictionary = [
			"instruments": [
				["visualization": "🎹"],
				["visualization": "🎸"],
				["visualization": "🎷"]
			]
		]
		
		let instruments = try! [Instrument](
			dictionary: JSON(dictionary: dictionary),
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
				dictionary: JSON(dictionary: dictionary),
				key: turKeyboard
			)
		){ error in switch error {
			case SerializableDictionaryError.noValue(let key):
				XCTAssertEqual(key, turKeyboard)
				
			default: XCTFail()
			}
		}
	}
}
