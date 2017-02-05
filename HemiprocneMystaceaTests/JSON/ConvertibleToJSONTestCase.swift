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
			reconstructedCrossBonez = 💀( json: try! JSON(crossBonez) )
		
		XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
	}
	
	func test_initializeNestedJSON() {
		let
			👻instance = 👻(
				boool: true,
				skoool: 💀(skool: "👠L")
			),
			reconstructed👻 = 👻( json: try! JSON(👻instance) )

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
				reconstruction = 👻( json: try! JSON(object: 👻object) )

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
	
	let boool: Bool
	let skoool: 💀
}
extension 👻: ConvertibleToJSON {
	enum JSONKey: String {
		case boool
		case skoool
	}
}
extension 👻: InitializableWithJSON {
	init(json: JSON) {
		self.init(
			boool: try! json.getValue(key: JSONKey.boool),
			skoool: 💀(
				json: try! JSON(
					object: json.getValue(key: JSONKey.skoool)
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
	init(json: JSON) {
		self.init(
			skool: try! json.getValue(key: JSONKey.skool)
		)
	}
}

