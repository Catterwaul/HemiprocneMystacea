import HM
import XCTest

final class ComparableTestCase: XCTestCase {
  func test_rangeOperators() {
    XCTAssertEqual(1...{ $0 + 2 }, 1...3)
    XCTAssertEqual(1..<{ $0 * 2 }, 1..<2)
  }

  func test_getMaxProperties() throws {
    struct Subject {
      let one = 1
      let two = 2
      let too = 2

      let `false` = false
    }

    let maxIntProperties = try XCTUnwrap(
      Int.max(ofPropertiesOf: Subject())
    )
    XCTAssertEqual(maxIntProperties.labels, ["two", "too"])
    XCTAssertEqual(maxIntProperties.value, 2)

    XCTAssertNil(
      Double.max(ofPropertiesOf: Subject())
    )

    XCTAssertEqual(
      Int.max(ofPropertiesOf: (1, 1))?.labels,
      [".0", ".1"]
    )

    XCTAssert(
      Int.max(ofPropertiesOf: [1])?.labels.isEmpty == true
    )
  }

  func test_clamped() {
    XCTAssertEqual("C".clamped(to: "F"..."P"), "F")
  }

  func test_isSorted() {
    let random = Int.random(in: 1...(.max))
    let stride = stride(from: -random, through: random, by: random)
    XCTAssert(stride.isSorted)
    XCTAssertFalse(stride.reversed().isSorted)
  }

  func test_localExtrema() {
    let (mininma, maxima) = [0, 1, 0, -1, -1, -1, 10, 11, -10].localExtrema
    XCTAssertEqual(mininma, [-1])
    XCTAssertEqual(maxima, [1, 11])
  }

  func test_minima() {
    XCTAssert(
      [1, -1000, 1000, -2, 1001].minima { $0.isMultiple(of: 2) }
      ==
      (1, -1000)
    )
  }

  func test_sort() {
    let sorted = (Int.min, Int.max)
    XCTAssert(sort(Int.max, .min) == sorted)
    XCTAssert(sort(Int.min, .max) == sorted)
  }
}
