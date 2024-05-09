import HM
import XCTest

final class GetThrowsMutatingSetTestCase: XCTestCase {
  func test_setWrappedValue() {
    var property = GetThrowsMutatingSet<_, AnyError>(wrappedValue: 0)
    XCTAssertEqual(try property.wrappedValue, 0)
    property.setWrappedValue(1)
    XCTAssertEqual(try property.wrappedValue, 1)
  }

  func test_map() {
    let property = GetThrowsMutatingSet<_, AnyError>(projectedValue: { true })
    XCTAssertEqual(try property.map { String($0) }.wrappedValue, "true")

    var property2 = property.map { (error: AnyError) in AnyError() }
    property2 = property2.map { _ in throw AnyError() }
    XCTAssertThrowsError(try property2.wrappedValue)
  }
}
