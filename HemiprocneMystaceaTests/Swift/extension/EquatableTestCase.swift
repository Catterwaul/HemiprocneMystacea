import HM
import XCTest

final class EquatableTestCase: XCTestCase {
	func test_typeWith1EquatableProperty() {
		let instances = (
			TypeWith1EquatableProperty(bool: true),
			TypeWith1EquatableProperty(bool: true)
		)
		XCTAssertEqual(
			instances.0,
			instances.1
		)
	}
	
	func test_typeWith2EquatableProperties() {
		let instances = (
			TypeWith2EquatableProperties(
				bool: true,
				double: 2
			),
			TypeWith2EquatableProperties(
				bool: true,
				double: 2
			)
		)
		XCTAssertEqual(
			instances.0,
			instances.1
		)
	}
	
	func test_typeWith5EquatableProperties() {
		let instance = TypeWith5EquatableProperties(
			bool: true,
			double: 2,
			float: 1,
			int: 800,
			string: "sdaffgqfejnjkn"
		)
		XCTAssertEqual(
			instance,
			instance
		)
	}
}

//MARK:
private struct TypeWith1EquatableProperty {
	let bool: Bool
}

//MARK: Equatable
extension TypeWith1EquatableProperty: Equatable {
	static func == (
		instance0: TypeWith1EquatableProperty,
		instance1: TypeWith1EquatableProperty
	) -> Bool {
		return instance0 == (instance1,
			{$0.bool}
		)
	}
}

//MARK:
private struct TypeWith2EquatableProperties {
	let bool: Bool
	let double: Double
}

//MARK: Equatable
extension TypeWith2EquatableProperties: Equatable {
	static func == (
		instance0: TypeWith2EquatableProperties,
		instance1: TypeWith2EquatableProperties
	) -> Bool {
		return instance0 == (instance1,
			{$0.bool},
			{$0.double}
		)
	}
}

//MARK:
private struct TypeWith5EquatableProperties {
	let bool: Bool
	let double: Double
	let float: Float
	let int: Int
	let string: String
}

//MARK: Equatable
extension TypeWith5EquatableProperties: Equatable {
	static func == (
		instance0: TypeWith5EquatableProperties,
		instance1: TypeWith5EquatableProperties
	) -> Bool {
		return instance0 == (instance1,
			{$0.bool},
			{$0.double},
			{$0.float},
			{$0.int},
			{$0.string}
		)
	}
}
