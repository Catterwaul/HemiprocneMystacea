import XCTest

final class SetAlgebraTestCase: XCTestCase {
  func test_contains() {
    var set: Set = [1, 2, 3]

    XCTAssert(set.contains[3])

    set.contains[1] = false
    XCTAssertEqual(set, [2, 3])

    var contains = set.contains

    contains[3].toggle()
    XCTAssertEqual(set, [2])

    contains.set = { _, _, _ in }
    contains[2].toggle()
    XCTAssertEqual(set, [2])

    var four: Set = [4]
    withUnsafeMutablePointer(to: &four) {
      contains.pointer = $0
      XCTAssert(contains[4])
    }
  }
}
