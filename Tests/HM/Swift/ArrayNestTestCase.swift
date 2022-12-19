import HM
import XCTest

final class ArrayNestTestCase: XCTestCase {
  func test() throws {
    @Reference var referenceArrayNest = ReferenceArrayNest.array(["🐈‍⬛"])
    var array = try referenceArrayNest.array
    array.append(.element("🐈"))
    XCTAssertThrowsError(try array[0].wrappedValue.array)
    array.append(.array())
    array.append(.array(["🐈‍⬛"]))
    referenceArrayNest = .array(array)
    let valueArrayNest = ValueArrayNest(referenceArrayNest)
    XCTAssertEqual(
      valueArrayNest,
      .array([.element("🐈‍⬛"), .element("🐈"), .array(), .array(["🐈‍⬛"])])
    )
    XCTAssertThrowsError(try valueArrayNest.array[0].array)
  }
}
