import HM
import XCTest

final class SerializableDictionaryTestCase: XCTestCase {
  func test_getValue() {
    let
      oldKey = "🗝",
      dictionary = [oldKey: "🔑"],
      serializableDictionary = SerializableDictionary(dictionary)
    
    XCTAssertEqual(
      try serializableDictionary[oldKey],
      "🔑"
    )
    
    let turKey = "🦃"
    XCTAssertThrowsError(
      try serializableDictionary[turKey] as Any
    ) { error in
      XCTAssertEqual(error as? Optional<Any>.UnwrapError, .nil)
    }
		
    XCTAssertThrowsError(
      try serializableDictionary[oldKey] as Bool
    ) { error in
      XCTAssertEqual(error as? Optional<Any>.UnwrapError, .typeMismatch)
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
      XCTAssertEqual(error as? Optional<Any>.UnwrapError, .nil)
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
      guard case InitializableWithSerializableDictionaryExtensions.Error.dataNotConvertibleToDictionaries = error
      else { return XCTFail() }
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
    visualization = try dictionary[SerializableDictionaryKey.visualization]
  }
}
