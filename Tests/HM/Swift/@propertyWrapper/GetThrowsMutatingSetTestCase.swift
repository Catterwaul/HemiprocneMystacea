import HM
import XCTest

final class GetThrowsMutatingSetTestCase: XCTestCase {
  func test_setWrappedValue() {
    var property = GetThrowsMutatingSet(wrappedValue: 0)
    XCTAssertEqual(try property.wrappedValue, 0)
    property.setWrappedValue(1)
    XCTAssertEqual(try property.wrappedValue, 1)
  }

  func test_map() {
    let property = GetThrowsMutatingSet(wrappedValue: true )
    XCTAssertEqual(try property.map { String($0) }.wrappedValue, "true")

    var property2 = property.map { _ in AnyError() }
    property2 = property2.map { _ in throw AnyError() }
    XCTAssertThrowsError(try property2.wrappedValue)
  }
}
