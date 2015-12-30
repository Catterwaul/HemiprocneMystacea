import HemiprocneMystacea
import XCTest

final class BoolTestCase: XCTestCase {
   func testToggle() {
      var bool = false
      bool.toggle()
      XCTAssertTrue(bool)
   }
}