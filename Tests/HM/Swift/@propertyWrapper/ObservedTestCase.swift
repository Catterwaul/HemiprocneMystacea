import HM
import XCTest

final class ObservedTestCase: XCTestCase {
  func test_wrapper() {
    struct Structure {
      @Observed var property = 0
    }

    var value: Int = 0
    var instance = Structure()

    instance.$property.willSet = { value = $0 }

    instance.property = 1
    XCTAssertEqual(value, 1)

    instance.$property.didSet = { oldValue, value in
      value = oldValue + value
    }

    instance.property = 2
    XCTAssertEqual(instance.property, 3)
  }
}
