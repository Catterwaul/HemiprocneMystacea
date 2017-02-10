import HM
import XCTest

final class SerializableDictionaryTestCase: XCTestCase {
	func test_getValue() {
		let
			oldKey = "🗝",
         dictionary = [oldKey: "🔑"],
			serializableDictionary = SerializableDictionary(dictionary)
		
		XCTAssertEqual(
			try serializableDictionary.getValue(key: oldKey),
			"🔑"
		)
		
		typealias Error = SerializableDictionary.GetValueError
      
		let turKey = "🦃"
		XCTAssertThrowsError(
			try serializableDictionary.getValue(key: turKey) as Any
		){	error in switch error {
         case Error.noValue(let key):
            XCTAssertEqual(key, turKey)
				
			default: XCTFail()
			}
		}
		
		XCTAssertThrowsError(
			try serializableDictionary.getValue(key: oldKey) as Bool
		){ error in switch error {
         case Error.typeCastFailure(let key):
				XCTAssertEqual(key, oldKey)
				
			default: XCTFail()
			}
		}
	}
	
	func test_InitializableWithSerializableDictionaryArray_init() {
		let dictionary = [
			"instruments": [
				[visualizationKey: "🎹"],
				[visualizationKey: "🎸"],
				[visualizationKey: "🎷"]
			]
		]
		
		let instruments = try! [Instrument](
			dictionary: dictionary,
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
				dictionary: dictionary,
				key: turKeyboard
			)
		){ error in switch error {
			case SerializableDictionary.GetValueError.noValue(let key):
				XCTAssertEqual(key, turKeyboard)
				
			default: XCTFail()
			}
		}
	}
	
	func test_convertInitializableWithSerializableDictionaryArray() {
		let instruments = [
			[visualizationKey: "🎹"],
			[visualizationKey: "🎸"],
			[visualizationKey: "🎷"]
		]
		XCTAssertEqual(
			try [Instrument](instruments),
			[	Instrument(visualization: "🎹"),
				Instrument(visualization: "🎸"),
				Instrument(visualization: "🎷")
			]
		)
	}
	
	func test_InitializationError() {
		XCTAssertThrowsError(
			try Instrument(
				jsonData: try JSONSerialization.data(
					withJSONObject: ["👿"]
				)
			)
		)
		
		XCTAssertThrowsError(
			try [Instrument](["👿"])
		)
	}
	
	private let visualizationKey =
		Instrument.SerializableDictionaryKey.visualization.rawValue
}

private struct Instrument {
	enum SerializableDictionaryKey: String {
		case visualization
	}

	let visualization: String
}

extension Instrument: InitializableWithSerializableDictionary {
	init(serializableDictionary dictionary: SerializableDictionary) throws {
		visualization = try dictionary.getValue(
			key: SerializableDictionaryKey.visualization
		)
	}
}

extension Instrument: Equatable {
	static func == (
		instrument0: Instrument,
		instrument1: Instrument
	) -> Bool {
		return instrument0 == (instrument1,
			{$0.visualization}
		)
	}
}
