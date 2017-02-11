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
		
		do {
			let jsonData = try crossBonez.makeJSONData()
			let reconstructedCrossBonez = try 💀(jsonData: jsonData)
			XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
		}
		catch {
			XCTFail()
		}
		
      do {
			let propertyListData = try crossBonez.makePropertyListData(format: .binary)
			let reconstructedCrossBonez = try 💀(propertyListData: propertyListData)
			XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
      }
		catch {
			XCTFail()
		}
	}
	
	func test_nestedReconstruct() {
		let 👻instance = 👻(
         boool: true,
         skoool: 💀(skool: "👠L")
      )
		
		typealias Error = SerializableDictionary.GetValueError
		
		do {
			let reconstructed👻 = try 👻(
				jsonData: try 👻instance.makeJSONData()
			)
			XCTAssertTrue(reconstructed👻.boool)
			XCTAssertEqual(reconstructed👻.skoool.skool, "👠L")
		}
		catch Error.noValue(let key) {
			XCTFail(key)
		}
		catch Error.typeCastFailure(let key) {
			XCTFail(key)
		}
		catch {XCTFail()}
		
		do {
			let reconstructed👻 = try 👻(
				propertyListData: try 👻instance.makePropertyListData(format: .binary)
			)
			XCTAssertTrue(reconstructed👻.boool)
			XCTAssertEqual(reconstructed👻.skoool.skool, "👠L")
		}
		catch Error.noValue(let key) {
			XCTFail(key)
		}
		catch Error.typeCastFailure(let key) {
			XCTFail(key)
		}
		catch {XCTFail()}
	}
	
	func test_initializeUsingKey() {
		typealias Error = SerializableDictionary.GetValueError
		
		let 👻instance = 👻(
			boool: false,
			skoool: 💀(skool: "🏫")
		)
		
		do {
			let
				data = try 👻instance.makeJSONData(key: "👻"),
				reconstruction = try 👻(
					jsonData: data,
					key: "👻"
				)
			XCTAssertFalse(reconstruction.boool)
			XCTAssertEqual(reconstruction.skoool.skool, "🏫")
		}
		catch Error.noValue(let key) {
			XCTFail(key)
		}
		catch Error.typeCastFailure(let key) {
			XCTFail(key)
		}
		catch {XCTFail()}

		do {
			let
				data = try 👻instance.makePropertyListData(
					format: .binary,
					key: "👻"
				),
				reconstruction = try 👻(
					propertyListData: data,
					key: "👻"
				)
			XCTAssertFalse(reconstruction.boool)
			XCTAssertEqual(reconstruction.skoool.skool, "🏫")
		}
		catch Error.noValue(let key) {
			XCTFail(key)
		}
		catch Error.typeCastFailure(let key) {
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
   init(serializableDictionary dictionary: SerializableDictionary) throws {
		self.init(
			boool: try dictionary.getValue(key: SerializableDictionaryKey.boool),
			skoool: try 💀(
				try dictionary.getValue(key: SerializableDictionaryKey.skoool)
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
   init(serializableDictionary dictionary: SerializableDictionary) throws {
		self.init(
			skool: try dictionary.getValue(key: SerializableDictionaryKey.skool)
		)
	}
}

