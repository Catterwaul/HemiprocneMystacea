import HM
import XCTest

final class SerializableDictionaryTestCase: XCTestCase {
  func test_getValue() {
    let
      oldKey = "🗝",
      dictionary = [oldKey: "🔑"],
      serializableDictionary = SerializableDictionary(dictionary)
    
    XCTAssertEqual(
      try serializableDictionary.value(for: oldKey),
      "🔑"
    )
		
    typealias Error<Value> = KeyValuePairs<String, Value>.AccessError
    
    let turKey = "🦃"
    XCTAssertThrowsError(
      try serializableDictionary.value(for: turKey) as Any
    ) { error in
      switch error {
      case Error<Any>.noValue(let key):
        XCTAssertEqual(key, turKey)
      default:
        XCTFail()
      }
    }
		
    XCTAssertThrowsError(
      try serializableDictionary.value(for: oldKey) as Bool
    ) { error in
      switch error {
      case Error<Bool>.typeCastFailure(let key):
        XCTAssertEqual(key, oldKey)
      default:
        XCTFail()
      }
    }
  }
	
  func test_InitializableWithSerializableDictionaryArray_init() throws {
    let dictionary = [
      "instruments": [
        [visualizationKey: "🎹"],
        [visualizationKey: "🎸"],
        [visualizationKey: "🎷"],
        [visualizationKey: nil]
      ]
    ]
    
    let instruments = try [Instrument](
      dictionary: dictionary,
      key: "instruments"
    )
    XCTAssertEqual(
      instruments.compactMap(\.visualization),
      ["🎹", "🎸", "🎷"]
    )
    
    let turKeyboard = "🦃⌨️"
    XCTAssertThrowsError(
      try [Instrument](
        dictionary: dictionary,
        key: turKeyboard
      )
    ) { error in
      switch error {
      case KeyValuePairs<String, Any>.AccessError.noValue(let key):
        XCTAssertEqual(key, turKeyboard)
      default:
        XCTFail()
      }
    }
  }
	
	func test_convertInitializableWithSerializableDictionaryArray() {
		let instruments = [
			[visualizationKey: "🎹"],
			[visualizationKey: "🎸"],
			[visualizationKey: "🎷"],
			[visualizationKey: nil]
		]
		XCTAssertEqual(
			try [Instrument](instruments),
			[	Instrument(visualization: "🎹"),
				Instrument(visualization: "🎸"),
				Instrument(visualization: "🎷"),
				Instrument(visualization: nil)
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
	
  func test_jsonDataNotConvertibleToDictionaries() {
    let jsonData = try! JSONSerialization.data(
      withJSONObject: ["🐈": "🐈"],
      options: []
    )
    
    XCTAssertThrowsError(
      try [Instrument](jsonData: jsonData)
    ) {	error in
      guard case InitializableWithSerializableDictionaryError.dataNotConvertibleToDictionaries = error
      else { XCTFail(); return }
    }
  }
	
	private let visualizationKey =
		Instrument.SerializableDictionaryKey.visualization.rawValue
}

private struct Instrument: Equatable {
  enum SerializableDictionaryKey: String {
    case visualization
  }
  
  let visualization: String?
}

extension Instrument: InitializableWithSerializableDictionary {
  init(serializableDictionary dictionary: SerializableDictionary) throws {
    visualization = try dictionary.value(
      for: SerializableDictionaryKey.visualization
    )
  }
}
