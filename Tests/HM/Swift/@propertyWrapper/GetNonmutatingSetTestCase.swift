import HM
import XCTest

final class GetNonmutatingSetTestCase: XCTestCase {
  func test_wrapper() {
    struct Structure {
      private(set) static var value: Int = 0

      @GetNonmutatingSet(set: { value = $0 }) var property = 1
    }

    var value: Int = .random
    var instance = Structure()

    XCTAssertEqual(Structure.value, 1)
    instance.$property = .init
      { value }
      set: { value = $0 }

    instance.property = 2
    XCTAssertEqual(value, 2)

    instance.$property.get = { 3 }
    XCTAssertEqual(instance.property, 3)

    instance.$property.set = { _ in }
    instance.property = 4
    XCTAssertNotEqual(4, value)
  }

  func test_capture() {
    func setValue<Value>(
      property: inout Value,
      value: Value
    ) {
      property = value
    }

    var value = 0
    @GetNonmutatingSet(get: { value }, set: { value = $0 }) var property;
    setValue(
      property: &property,
      value: 777
    )
    XCTAssertEqual(property, 777)
  }
}
