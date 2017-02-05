import HM
import XCTest

final class ConvertibleToSerializableDictionaryTestCase: XCTestCase {
	func test_serializableDictionary() {
		XCTAssertEqual(
			💀(skool: "🏫").serializableDictionary as! [String: String],
			["skool": "🏫"]
		)
	}
	
	func test_reconstruct() {
		let crossBonez = 💀(skool: "☠️")
      var reconstructedCrossBonez = try! 💀(
         dictionary: try! JSON(crossBonez)
      )
		XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
      do {
         reconstructedCrossBonez = try 💀(
            dictionary: try PropertyList(crossBonez)
         )
         XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
      }
      catch is SerializableDictionaryInitializationError {
         XCTFail()
      }
      catch SerializableDictionaryError.noValue(let key) {
         XCTFail(key)
      }
      catch SerializableDictionaryError.typeCastFailure(let key) {
         XCTFail(key)
      }
      catch let error as NSError {
         XCTFail(error.description)
      }
	}
	
	func test_nestedReconstruct() {
		let 👻instance = 👻(
         boool: true,
         skoool: 💀(skool: "👠L")
      )
			
      var reconstructed👻 = try! 👻(
         dictionary: try! JSON(👻instance)
      )
		XCTAssertTrue(reconstructed👻.boool)
		XCTAssertEqual(reconstructed👻.skoool.skool, "👠L")
      reconstructed👻 = try! 👻(
         dictionary: try! PropertyList(👻instance)
      )
      XCTAssertTrue(reconstructed👻.boool)
      XCTAssertEqual(reconstructed👻.skoool.skool, "👠L")
	}
	
	func test_initializeUsingKey() {
		do {
			var data = try Data(
            key: "👻",
            convertibleToJSON: 👻(
               boool: false,
               skoool: 💀(skool: "🏫")
            )
         )
				
         let json = try JSON(data: data)
         var 👻object: Any = try json.getValue(key: "👻")
         var reconstruction = try 👻(
            dictionary: try JSON(dictionary: 👻object)
         )

			XCTAssertFalse(reconstruction.boool)
			XCTAssertEqual(reconstruction.skoool.skool, "🏫")
         
         data = try Data(
            key: "👻",
            convertibleToPropertyList: 👻(
               boool: false,
               skoool: 💀(skool: "🏫")
            )
         )
         
         let propertyList = try PropertyList(data: data)
         👻object = try propertyList.getValue(key: "👻")
         reconstruction = try 👻(
            dictionary: try PropertyList(dictionary: 👻object)
         )
         
         XCTAssertFalse(reconstruction.boool)
         XCTAssertEqual(reconstruction.skoool.skool, "🏫")
		}
		catch SerializableDictionaryError.noValue(let key) {
			XCTFail(key)
		}
		catch SerializableDictionaryError.typeCastFailure(let key) {
			XCTFail(key)
		}
		catch {XCTFail()}
	}

}

//MARK:
private struct 👻 {
	init(
		boool: Bool,
		skoool: 💀
	) {
		self.boool = boool
		self.skoool = skoool
	}
	
	let boool: Bool
	let skoool: 💀
}

extension 👻: ConvertibleToSerializableDictionary {
	enum SerializableDictionaryKey: String {
		case boool
		case skoool
	}
}

extension 👻: InitializableWithSerializableDictionary {
   init<Dictionary: SerializableDictionary>(
      dictionary: Dictionary
   ) throws {
		self.init(
			boool: try dictionary.getValue(key: SerializableDictionaryKey.boool),
			skoool: try 💀(
				dictionary: try Dictionary(
					dictionary: dictionary.getValue(key: SerializableDictionaryKey.skoool)
				)
			)
		)
	}
}

//MARK:
private struct 💀 {
	let skool: String
	
	// Json wears a regular hockey mask, not a field hockey one.
	let nonJSONProperty = "🏑"
}

extension 💀: ConvertibleToSerializableDictionary {
	enum SerializableDictionaryKey: String {
		case skool
	}
}

extension 💀: InitializableWithSerializableDictionary {
   init<Dictionary: SerializableDictionary>(
      dictionary: Dictionary
   ) throws {
		self.init(
			skool: try dictionary.getValue(key: SerializableDictionaryKey.skool)
		)
	}
}

