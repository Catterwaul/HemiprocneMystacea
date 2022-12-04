import HM
import XCTest

final class RangeExpressionTestCase: XCTestCase {
  func test_contains() {
    let lowerBound = 1
    let upperBound = 10
    let range = lowerBound..<upperBound
    let partialRangeFrom = lowerBound...
    let partialRangeUpTo = ..<upperBound
    var partialRangeThrough: PartialRangeThrough<Int> { .init(partialRangeUpTo) }
    var closedRange: ClosedRange<Int> { .init(range) }

    XCTAssert(closedRange.contains(range))
    XCTAssertFalse(closedRange.contains(partialRangeFrom))
    XCTAssertFalse(closedRange.contains(partialRangeThrough))
    XCTAssertFalse(closedRange.contains(partialRangeUpTo))

    XCTAssert(partialRangeFrom.contains(closedRange))
    XCTAssert(partialRangeFrom.contains(partialRangeFrom))
    XCTAssertFalse(partialRangeFrom.contains(partialRangeThrough))
    XCTAssertFalse(partialRangeFrom.contains(partialRangeUpTo))
    XCTAssert(partialRangeFrom.contains(range))

    XCTAssert(partialRangeThrough.contains(range))
    XCTAssertFalse(partialRangeThrough.contains(partialRangeFrom))
    XCTAssert(partialRangeThrough.contains(partialRangeUpTo))

    XCTAssert(partialRangeUpTo.contains(closedRange))
    XCTAssertFalse(partialRangeUpTo.contains(partialRangeFrom))
    XCTAssert(partialRangeUpTo.contains(partialRangeThrough))
    XCTAssert(partialRangeUpTo.contains(partialRangeUpTo))
    XCTAssert(partialRangeUpTo.contains(range))

    XCTAssert(range.contains(closedRange))
    XCTAssertFalse(range.contains(partialRangeFrom))
    XCTAssertFalse(range.contains(partialRangeThrough))
    XCTAssertFalse(range.contains(partialRangeUpTo))
    XCTAssert(range.contains(range))
  }
}
