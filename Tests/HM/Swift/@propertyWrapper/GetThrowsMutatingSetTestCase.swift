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
    var boolError = GetThrowsMutatingSet(wrappedValue: true )
    XCTAssertEqual(try boolError.map { String($0) }.wrappedValue, "true")

    let boolAnyError = boolError.mapError { _ in AnyError() }
    boolError = boolAnyError.map { try $0() }
    XCTAssertTrue(try boolError.wrappedValue)
  }
}
