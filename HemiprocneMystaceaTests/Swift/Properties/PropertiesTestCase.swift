import HemiprocneMystacea
import XCTest

final class PropertiesTestCase: XCTestCase {
	func testComputedProperty() {
		var _property = 0

		let property1 = ComputedProperty(
			get: {_property},
			set: {_property = $0}
		)
		property1.set(5)
		XCTAssertEqual(
			property1.get(),
			5
		)

		let property2 = ComputedProperty(
			property1,
			get: {3}
		)
		XCTAssertEqual(
			property2.get(),
			3
		)

		let property3 = ComputedProperty(
			property2,
			set: {_ in}
		)
		property3.set(100)
		XCTAssertNotEqual(
			100,
			property3.get()
		)
	}
	
	func testObservedProperty() {
		let property1 = ObservedProperty(
      value: 1,
      didSet: {_ in}
    )
		XCTAssertEqual(
			property1.value,
			1
		)

		var property2 = ObservedProperty(
			property1,
			didSet: {
			(	oldValue: Int,
				inout value: Int
			) in
				value = oldValue - 1
			}
		)
		property2.value = 2
    XCTAssertEqual(
      property2.value,
      0
    )
  }
}