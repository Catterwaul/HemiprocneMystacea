import HM
import XCTest

final class CABasicAnimationTestCase: XCTestCase {
	func testInit() {
		_ = CABasicAnimation(
			keyPath: "",
			values: CABasicAnimation.Values(
				from: CGFloat(0),
				to: CGFloat(2 * M_PI)
			),
			duration: 0
		)
	}
}
