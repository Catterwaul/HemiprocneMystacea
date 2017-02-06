import HM
import XCTest

final class SerializableDictionaryTestCase: XCTestCase {
	func test_getValue() {
		let
			oldKey = "🗝",
         dictionary = [oldKey: "🔑"],
			json = try! JSON(dictionary: dictionary),
         pList = try! PropertyList(dictionary: dictionary)
		
		XCTAssertEqual(
			try json.getValue(key: oldKey),
			"🔑"
		)
      XCTAssertEqual(
         try pList.getValue(key: oldKey),
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
         try pList.getValue(key: turKey) as Any
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
      
      XCTAssertThrowsError(
         try pList.getValue(key: oldKey) as Bool
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
         ) throws {
				visualization = try dictionary.getValue(key: "visualization")
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
		
		var instruments = try! [Instrument](
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
      
      instruments = try! [Instrument](
         dictionary: PropertyList(dictionary: dictionary),
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
      XCTAssertThrowsError(
         try [Instrument](
            dictionary: PropertyList(dictionary: dictionary),
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
