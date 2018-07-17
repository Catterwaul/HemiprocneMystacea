import HM
import XCTest

final class PropertiesTestCase: XCTestCase {
	func test_computedProperty() {
		var _property = 0

		let property1 = ComputedProperty(
			get: { _property },
			set: { _property = $0 }
		)
		
		property1.value = 5
		XCTAssertEqual(property1.value, 5)

		let property2 = ComputedProperty(
			property1,
			get: { 3 }
		)
		XCTAssertEqual(property2.value, 3)

		let property3 = ComputedProperty(
			property2,
			set: { _ in }
		)
		property3.value = 100
		XCTAssertNotEqual(100, property3.value)
	}
	
	func test_observedProperty() {
		let property1 = ObservedProperty(
      value: 1,
      didSet: { _, _ in }
    )
		XCTAssertEqual(property1.value, 1)

		let property2 = ObservedProperty(
			property1,
			didSet: {
				(
					oldValue: Int,
					value: inout Int
				) in
				
				value = oldValue - 1
			}
		)
		property2.value = 2
		XCTAssertEqual(property2.value, 0)
  }

	func test_captureProperty() {
		func setValue<Property: HM.Property>(
			property: Property,
			value: Property.Value
		) {
			property.value = value
		}

		var _property = 0
		let property = ComputedProperty(
			get: { _property },
			set: { _property = $0 }
		)
		setValue(
			property: property,
			value: 777
		)

		XCTAssertEqual(property.value, 777)
	}
}
