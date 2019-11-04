import HM
import XCTest

final class CGRectTestCase: XCTestCase {
	func test_center() {
		XCTAssertEqual(
			CGRect(
				x: -100, y: -200,
				width: 200, height: 400
			).center,
			.zero
		)
	}
	
  func test_max() {
    XCTAssertEqual(
      CGRect(
        x: -100, y: -200,
        width: 200, height: 400
      ).max,
      CGPoint(x: 100, y: 200)
    )
  }
	
//MARK: init
	func test_initWithSize() {
		XCTAssertEqual(
			CGRect(
				x: 0, y: 0,
				size: CGSize(width: 4, height: 4)
			),
			CGRect(
				x: 0, y: 0,
				width: 4, height: 4
			)
		)
	}
}
