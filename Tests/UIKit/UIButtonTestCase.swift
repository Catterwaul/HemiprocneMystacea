#if !(os(macOS) || os(watchOS))
import XCTest

final class UIButtonTestCase: XCTestCase {
   func test_disabledAndDim() {
		let button = UIButton()
		
		button.disabledAndDim = true
		XCTAssert(button.disabledAndDim)
		XCTAssertEqual(button.alpha, 0.5)
		
		button.disabledAndDim = false
		XCTAssertFalse(button.disabledAndDim)
		XCTAssertEqual(button.alpha, 1)
   }
}
#endif
