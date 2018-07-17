import HM
import XCTest

final class ConvertibleToSerializableDictionaryTestCase: XCTestCase {
	func test_serializableDictionary() {
		XCTAssertEqual(
			💀(skool: "🏫").makeSerializableDictionary(
				jsonCompatible: true
			) as! [String: String],
			["skool": "🏫"]
		)
	}
	
	func test_Date() {
		let instance = 🐭()
	
		XCTAssertEqual(
			instance.date,
			instance
				.makeSerializableDictionary(jsonCompatible: false)[
					🐭.SerializableDictionaryKey.date.rawValue
				] as? Date
		)
		
		XCTAssertEqual(
			instance.date,
			Date(
				timeIntervalSinceReferenceDate:
					instance
					.makeSerializableDictionary(jsonCompatible: true)[
						🐭.SerializableDictionaryKey.date.rawValue
					] as! Double
			)
		)
	}
	
	func test_UIImage() {
		let instance = 🐭()
		
		XCTAssertTrue(
			UIImage(
				data:
					instance
					.makeSerializableDictionary(jsonCompatible: false)[
						🐭.SerializableDictionaryKey.image.rawValue
					] as! Data
			)!.hasEqualPixels(instance.image)
		)
		
		XCTAssertTrue(
			UIImage(
				data: Data(
					base64Encoded:
						instance
						.makeSerializableDictionary(jsonCompatible: true)[
							🐭.SerializableDictionaryKey.image.rawValue
						] as! String
				)!
			)!.hasEqualPixels(instance.image)
		)
	}
	
  func test_reconstruct() throws {
    let crossBonez = 💀(skool: "☠️")
    
    do {
      let jsonData = try crossBonez.makeJSONData()
      let reconstructedCrossBonez = try 💀(jsonData: jsonData)
      XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
    }
    
    do {
      let propertyListData = try crossBonez.makePropertyListData(format: .binary)
      let reconstructedCrossBonez = try 💀(propertyListData: propertyListData)
      XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
    }
  }
	
	func test_reconstructUsingOptional() {
		let crossBonez = 💀(skool: nil)
		
		do {
			let jsonData = try crossBonez.makeJSONData()
			let reconstructedCrossBonez = try 💀(jsonData: jsonData)
			XCTAssertNil(reconstructedCrossBonez.skool)
		}
		catch let error as NSError {
			XCTFail(error.description)
		}
		
    typealias Error = GetValueForKeyError<String>

		do {
			let propertyListData = try crossBonez.makePropertyListData(format: .binary)
			let reconstructedCrossBonez = try 💀(propertyListData: propertyListData)
			XCTAssertNil(reconstructedCrossBonez.skool)
		}
		catch Error.noValue(let key) {
			XCTFail(key)
		}
		catch Error.typeCastFailure(let key) {
			XCTFail(key)
		}
		catch let error as NSError {
			XCTFail(error.description)
		}
	}
	
	func test_nestedReconstruct() throws {
		let 👻instance = 👻(
         boool: true,
         skoool: 💀(skool: "👠L")
      )
		
		typealias Error = GetValueForKeyError<String>
		
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
	}
  
  func test_reconstructArray() throws {
    let array = Array(
      repeating: 👻(
        boool: true,
        skoool: 💀(skool: "👠L")
      ),
      count: 3
    )
    
    do {
      let jsonData = try array.makeJSONData()
      let reconstructedArray = try [💀](jsonData: jsonData)
      XCTAssertEqual(reconstructedArray.count, 3)
    }
    
    do {
      let propertyListData = try array.makePropertyListData(format: .binary)
      let reconstructedArray = try [💀](propertyListData: propertyListData)
      XCTAssertEqual(reconstructedArray.count, 3)
    }
    
    let 👻sInstance = 👻s(array: array)
    _ = try 👻sInstance.makeJSONData()
    _ = try 👻sInstance.makePropertyListData(format: .binary)
  }
	
	func test_initializeUsingKey() throws {
		typealias Error = GetValueForKeyError<String>
		
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
private struct 👻s: ConvertibleToSerializableDictionary {
	enum SerializableDictionaryKey: String {
		case array
	}
	
	let array: [👻]
}

//MARK:
private struct 💀 {
	let skool: String?
	
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
		typealias Error = GetValueForKeyError<String>
		do {
			self.init(
				skool: try dictionary.getValue(key: SerializableDictionaryKey.skool)
			)
		}
		catch Error.typeCastFailure(let key) {
			throw Error.typeCastFailure(key: key)
		}
		catch { self.init(skool: nil) }
	}
}


//MARK:
private struct 🐭: ConvertibleToSerializableDictionary {
	enum SerializableDictionaryKey: String {
		case date
		case image
	}
	
	let date = Date()
	
	let image = UIImage(
		named: "Mousse with Mouse.png",
		in: Bundle(for: ConvertibleToSerializableDictionaryTestCase.self),
		compatibleWith: nil
	)!
}
