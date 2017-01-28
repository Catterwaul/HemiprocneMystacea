import HM
import XCTest

final class CALayerTestCase: XCTestCase {
	func test_KeyPath() {
		XCTAssertEqual(
			CALayer.KeyPath.rotation,
			"transform.rotation"
		)
		XCTAssertEqual(
			CALayer.KeyPath.scale,
			"transform.scale"
		)
		XCTAssertEqual(
			CALayer.KeyPath.translation,
			"transform.translation"
		)
	}
}
