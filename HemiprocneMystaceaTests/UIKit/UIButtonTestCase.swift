import HemiprocneMystacea
import XCTest

final class UIButtonTestCase: XCTestCase {
   func testDisabledAndDim() {
		let button = UIButton()
		
		button.disabledAndDim = true
		XCTAssertTrue(button.disabledAndDim)
		XCTAssertEqual(button.alpha, 0.5)
		
		button.disabledAndDim = false
		XCTAssertFalse(button.disabledAndDim)
		XCTAssertEqual(button.alpha, 1)
   }
}
