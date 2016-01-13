import HemiprocneMystacea
import XCTest

final class NSObjectTestCase: XCTestCase {
   func testName() {
      XCTAssertEqual(NSObject.className, "NSObject")
      XCTAssertEqual(NSString.className, "NSString")
   }
}