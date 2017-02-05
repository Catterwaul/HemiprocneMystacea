import HM
import XCTest

final class ConvertibleToJSONTestCase: XCTestCase {
	func test_jsonDictionary() {
		XCTAssertEqual(
			💀(skool: "🏫").jsonDictionary as! [String: String],
			["skool": "🏫"]
		)
	}
	
	func test_initializeJSON() {
		let
			crossBonez = 💀(skool: "☠️"),
			reconstructedCrossBonez = 💀(
            dictionary: try! JSON(crossBonez)
         )
		
		XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
	}
	
	func test_initializeNestedJSON() {
		let
			👻instance = 👻(
				boool: true,
				skoool: 💀(skool: "👠L")
			),
			reconstructed👻 = 👻(
            dictionary: try! JSON(👻instance)
         )

		XCTAssertTrue(reconstructed👻.boool)
		XCTAssertEqual(reconstructed👻.skoool.skool, "👠L")
	}
	
	func test_initializeJSONUsingKey() {
		do {
			let
				data = try! Data(
					key: "👻",
					value: 👻(
						boool: false,
						skoool: 💀(skool: "🏫")
					)
				),
				json = try! JSON(data: data),
				👻object: Any = try json.getValue(key: "👻"),
				reconstruction = 👻(
               dictionary: try! JSON(dictionary: 👻object)
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

extension 👻: ConvertibleToJSON {
	enum JSONKey: String {
		case boool
		case skoool
	}
}

extension 👻: InitializableWithSerializableDictionary {
   init<Dictionary: SerializableDictionary>(
      dictionary: Dictionary
   ) {
		self.init(
			boool: try! dictionary.getValue(key: JSONKey.boool),
			skoool: 💀(
				dictionary: try! JSON(
					dictionary: dictionary.getValue(key: JSONKey.skoool)
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

extension 💀: ConvertibleToJSON {
	enum JSONKey: String {
		case skool
	}
}

extension 💀: InitializableWithSerializableDictionary {
   init<Dictionary: SerializableDictionary>(
      dictionary: Dictionary
   ) {
		self.init(
			skool: try! dictionary.getValue(key: JSONKey.skool)
		)
	}
}

