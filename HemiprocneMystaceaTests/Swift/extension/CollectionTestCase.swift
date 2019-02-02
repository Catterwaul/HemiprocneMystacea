import HM
import XCTest

final class CollectionTestCase: XCTestCase {
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
