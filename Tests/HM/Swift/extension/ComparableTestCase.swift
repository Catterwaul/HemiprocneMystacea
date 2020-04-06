import HM
import XCTest

final class ComparableTestCase: XCTestCase {
  func test_getMaxProperties() throws {
    struct Subject {
      let one = 1
      let two = 2
      let too = 2

      let `false` = false
    }

    let maxIntProperties = try XCTUnwrap(
      Int.getMax( Subject() )
    )
    XCTAssertEqual(maxIntProperties.labels, ["two", "too"])
    XCTAssertEqual(maxIntProperties.value, 2)

    XCTAssertNil(
      Double.getMax( Subject() )
    )

    XCTAssertEqual(
      Int.getMax( (1, 1) )?.labels,
      [".0", ".1"]
    )

    XCTAssert(
      Int.getMax([1])?.labels.isEmpty == true
    )
  }

  func test_clamped() {
    XCTAssertEqual("C".clamped(to: "F"..."P"), "F")
  }
}
