import XCTest

final class UIColorTestCase: XCTestCase {
	func test_hsba() {
		let
			color = #colorLiteral(red: 0.25, green: 0.5, blue: 0.5, alpha: 0.5),
			hsba = try! UIColor.HSBA(color)
		
		XCTAssertEqual(hsba.hue, 0.5)
		XCTAssertEqual(hsba.saturation, 0.5)
		XCTAssertEqual(hsba.brightness, 0.5)
		XCTAssertEqual(hsba.alpha, 0.5)
		
		XCTAssertEqual( UIColor(hsba), color )
	}
}
