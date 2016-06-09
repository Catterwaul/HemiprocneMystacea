import HemiprocneMystacea
import XCTest

final class UIButtonTestCase: XCTestCase {
   func testDisabledAndDim() {
      XCTAssertTrue(
        (UIButton()…{$0.disabledAndDim = true}).disabledAndDim
      )
   }
}