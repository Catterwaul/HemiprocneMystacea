import HM
import Testing
import class Foundation.JSONSerialization

struct SerializableDictionaryTests {
  @Test func getValue() throws {
    let
      oldKey = "🗝",
      dictionary = [oldKey: "🔑"],
      serializableDictionary = SerializableDictionary(dictionary)
    
    #expect(try serializableDictionary[oldKey] == "🔑")
    
    let turKey = "🦃"
    #expect(throws: Any?.Nil.self) { try serializableDictionary[turKey] as Any }

    #expect(throws: CastError.impossible) { try serializableDictionary[oldKey] as Bool }
  }
	
  @Test func InitializableWithSerializableDictionaryArray_init() throws {
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
    #expect(instruments.compactMap(\.visualization) == ["🎹", "🎸", "🎷"])
    
    let turKeyboard = "🦃⌨️"
    #expect(throws: Any?.Nil.self) {
      try [Instrument](dictionary: dictionary, key: turKeyboard)
    }
  }
	
  @Test func convertInitializableWithSerializableDictionaryArray() throws {
		let instruments = [
			[visualizationKey: "🎹"],
			[visualizationKey: "🎸"],
			[visualizationKey: "🎷"],
			[visualizationKey: nil]
		]
    #expect(
			try [Instrument](instruments)
      ==
			[	Instrument(visualization: "🎹"),
				Instrument(visualization: "🎸"),
				Instrument(visualization: "🎷"),
				Instrument(visualization: nil)
			]
		)
	}
	
  @Test func InitializationError() {
    #expect(throws: (any Error).self) {
      try Instrument(
        jsonData: try JSONSerialization.data(withJSONObject: ["👿"])
      )
    }

    #expect(throws: (any Error).self) { try [Instrument](["👿"]) }
  }
	
  @Test func jsonDataNotConvertibleToDictionaries() throws {
    let jsonData = try! JSONSerialization.data(
      withJSONObject: ["🐈": "🐈"],
      options: []
    )
    
    #expect(throws: InitializableWithSerializableDictionaryExtensions.Error.dataNotConvertibleToDictionaries) {
      try [Instrument](jsonData: jsonData)
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
