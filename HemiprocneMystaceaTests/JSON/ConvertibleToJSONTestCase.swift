import HemiprocneMystacea
import XCTest

final class ConvertibleToJSONTestCase: XCTestCase {
	func test_💀_jSONDictionary() {
		XCTAssertEqual(
			💀(skool: "🏫").jSONDictionary as! [String: String],
			["skool": "🏫"]
		)
	}
	
	func test_initDataWith💀() {
		let
		crossBonez = 💀(skool: "☠️"),
		reconstructedCrossBonez = 💀(
			jSON: try! JSON(crossBonez)
		)
		
		XCTAssertEqual(reconstructedCrossBonez.skool, "☠️")
	}
	
	func test_👻() {
		let
		default👻 = 👻(
			boool: true,
			skoool: 💀(skool: "👠L")
		),
		reconstructedDefault👻 = 👻(
			jSON: try! JSON(default👻)
		)

		XCTAssertTrue(reconstructedDefault👻.boool)
		XCTAssertEqual(reconstructedDefault👻.skoool.skool, "👠L")
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
			boool: try! jSON.get_value(key: JSONKey.boool),
			skoool: 💀(
				jSON: try! JSON(
					jSON.get_value(key: JSONKey.skoool)
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
			skool: try! jSON.get_value(key: JSONKey.skool)
		)
	}
}

