import HemiprocneMystacea
import XCTest

final class IntegersTestCase: XCTestCase {
   func testDivisibleBy() {
      XCTAssertTrue(4.divisible(by: 2))
      XCTAssertFalse(33.divisible(by: 8))
   }
}