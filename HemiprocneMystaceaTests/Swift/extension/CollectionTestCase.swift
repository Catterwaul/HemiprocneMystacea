import HM
import XCTest

final class CollectionTestCase: XCTestCase {
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
