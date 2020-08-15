import HM
import XCTest

import SwiftUI

final class PropertiesTestCase: XCTestCase {
  func test_Computed() {
    struct Structure<Value> {
      @Computed var property: Value
    }

    var value = 0
    var instance = Structure(
      property: .init
        { value }
        set: { value = $0 }
    )

    instance.property = 5
    XCTAssertEqual(value, 5)

    instance.$property.get = { 3 }
    XCTAssertEqual(instance.property, 3)

    instance.$property.set = { _ in }
    instance.property = 100
    XCTAssertNotEqual(100, value)
  }

  func test_Computed_capture() {
    func setValue<Value>(
      property: inout Computed<Value>,
      value: Value
    ) {
      property.wrappedValue = value
    }

    var value = 0
    var property = Computed(
      get: { value },
      set: { value = $0 }
    )
    setValue(
      property: &property,
      value: 777
    )

    XCTAssertEqual(property.wrappedValue, 777)
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
}
