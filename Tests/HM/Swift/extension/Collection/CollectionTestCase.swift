import HM
import XCTest

final class CollectionTestCase: XCTestCase {
  func test_tupleEquality() {
    let intStringTuples = [(1, "a"), (2, "b")]
    XCTAssertTrue(intStringTuples == intStringTuples)
    XCTAssertFalse(intStringTuples == [ intStringTuples[0] ])

    let boolDoubleTuples = [(true, 1.2), (false, 3.4)]
    XCTAssert(boolDoubleTuples == boolDoubleTuples)

    let threeTuples = intStringTuples.map { ($0.0, false, $0.1) }
    XCTAssertTrue(threeTuples == threeTuples)
    XCTAssertFalse(threeTuples == [])
  }

  func test_shifted() {
    XCTAssertEqual(
      [0, 1, 2, 3].shifted(by: 1),
      [1, 2, 3, 0]
    )

    XCTAssertEqual(
      [0, 1, 2, 3].shifted(by: -1),
      [3, 0, 1, 2]
    )
  }

  func test_prefix() {
    XCTAssertEqual(
      "glorb14prawn".prefix(upTo: "1"),
      "glorb"
    )
    
    XCTAssertEqual(
      "glorb14prawn".prefix(through: "1"),
      "glorb1"
    )

    XCTAssertNil( "boogalawncare".prefix(upTo: "z") )
    XCTAssertNil( "boogalawncare".prefix(through: "z") )
  }
  
  func test_suffix() {
    XCTAssertEqual(
      "chunky skunky".suffix(from: "s"),
      "kunky"
    )
    XCTAssertNil( "aaabbbccc".suffix(from: "z") )
  }
}
