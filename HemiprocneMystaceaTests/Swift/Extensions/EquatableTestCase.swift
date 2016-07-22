import HM
import XCTest

final class EquatableTestCase: XCTestCase {
	func testTypeWith1EquatableProperty() {
		let instances = (
			TypeWith1EquatableProperty(bool: true),
			TypeWith1EquatableProperty(bool: true)
		)
		XCTAssertEqual(
			instances.0,
			instances.1
		)
	}
	
	func testTypeWith2EquatableProperties() {
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
	
	func testTypeWith5EquatableProperties() {
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

private struct TypeWith1EquatableProperty: Equatable {
	let bool: Bool
}
private func == (
	instance0: TypeWith1EquatableProperty,
	instance1: TypeWith1EquatableProperty
) -> Bool {
	return instance0 == (instance1,
		{$0.bool}
	)
}

private struct TypeWith2EquatableProperties: Equatable {
	let
		bool: Bool,
		double: Double
}
private func == (
	instance0: TypeWith2EquatableProperties,
	instance1: TypeWith2EquatableProperties
) -> Bool {
	return instance0 == (instance1,
		{$0.bool},
		{$0.double}
	)
}

private struct TypeWith5EquatableProperties: Equatable {
	let
		bool: Bool,
		double: Double,
		float: Float,
		int: Int,
		string: String
}
private func == (
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
