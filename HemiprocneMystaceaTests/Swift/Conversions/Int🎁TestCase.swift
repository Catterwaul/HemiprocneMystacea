import HemiprocneMystacea
import XCTest

final class Int🎁TestCase: XCTestCase {
   func testString() {
      XCTAssertEqual("4".Int, 4)
      XCTAssertEqual("A".Int(radix: 0xF), 10)
   }
}