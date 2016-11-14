import HM
import XCTest

final class ConvertibleToJSONTestCase: XCTestCase {
	func test_jsonDictionary() {
		XCTAssertEqual(
			💀(skool: "🏫").jSONDictionary as! [String: String],
			["skool": "🏫"]
		)
	}
	
	func test_initializeJSON() {
		let
		crossBonez = 💀(skool: "☠️"),
		reconstructedCrossBonez = 💀(
			jSON: try! JSON(crossBonez)
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
			jSON: try! JSON(👻instance)
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
			jSON = try! JSON(data: data),
			👻object: AnyObject = try jSON.getValue(key: "👻"),
			reconstruction = 👻(
				jSON: JSON(object: 👻object)
				
			)

			XCTAssertFalse(reconstruction.boool)
			XCTAssertEqual(reconstruction.skoool.skool, "🏫")
		}
		catch JSON.Error.noValue(let key) {
			XCTFail(key)
		}
		catch JSON.Error.typeCastFailure(let key) {
			XCTFail(key)
		}
		catch {XCTFail()}
	}

}

private struct 👻 {
	init(
		boool: Bool,
		skoool: 💀
	) {
		self.boool = boool
		self.skoool = skoool
	}
	
	let
	boool: Bool,
	skoool: 💀
}
extension 👻: ConvertibleToJSON {
	enum JSONKey: String {
		case boool, skoool
	}
}
extension 👻: InitializableWithJSON {
	init(jSON: JSON) {
		self.init(
			boool: try! jSON.getValue(key: JSONKey.boool),
			skoool: 💀(
				jSON: try! JSON(
					object: jSON.getValue(key: JSONKey.skoool)
				)
			)
		)
	}
}

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
extension 💀: InitializableWithJSON {
	init(jSON: JSON) {
		self.init(
			skool: try! jSON.getValue(key: JSONKey.skool)
		)
	}
}

