import HemiprocneMystacea
import XCTest

final class UIButtonTestCase: XCTestCase {
   func testDisabledAndDim() {
      let button = UIButton()
      button.disabledAndDim = true
      XCTAssertEqual(button.disabledAndDim, true)
   }
}