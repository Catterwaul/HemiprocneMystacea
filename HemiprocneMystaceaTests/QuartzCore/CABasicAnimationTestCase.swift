import HemiprocneMystacea
import XCTest

final class CABasicAnimationTestCase: XCTestCase {
	func testInit() {
		let values = CABasicAnimation_Values(
			from: CGFloat(0),
			to: CGFloat(2 * M_PI)
		)
		_ = CABasicAnimation(
			keyPath: "",
			values: values,
			duration: 0
		)
	}
}