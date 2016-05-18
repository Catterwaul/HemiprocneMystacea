import HemiprocneMystacea
import XCTest

final class MutablePropertiesTestCase: XCTestCase {
	func testMutableComputedProperty() {
		var _property = 0
		var property = MutableComputedProperty(
			get: {_property},
			set: {_property = $0}
		)
		property.set(5)
		XCTAssertEqual(
			property.get(),
			5
		)
		property.get = {3}
		XCTAssertEqual(
			property.get(),
			3
		)
		property.set = {_ in}
		property.set(100)
		XCTAssertNotEqual(
			_property,
			property.get()
		)
	}
	
	func testMutableObservableProperty() {
		var property = MutableObservableProperty(value: 1)
		XCTAssertEqual(
			property.value,
			1
		)
		
		func didSet(
			oldValue: Int,
			inout value: Int
		) {
			value = oldValue - 1
		}
		property.didSet = didSet
		property.value = 2
		XCTAssertEqual(property.value, 0)
	}
}