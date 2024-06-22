#if !(os(watchOS))
import HM
import UIKit_HM
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

  func test_getSublayers() {
    let layer = CALayer()
    XCTAssertEqual(layer.getSublayers(), [])

    final class Sublayer: CALayer { }

    layer.addSublayer(Sublayer())
    XCTAssertNotNil(layer.getSublayer() as? Sublayer)
  }
}
#endif
