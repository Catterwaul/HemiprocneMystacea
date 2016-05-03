import HemiprocneMystacea
import XCTest

final class CABasicAnimationTestCase: XCTestCase {
	func testInit() {
		let values = CABasicAnimation_Values(
			from: 4,
			to: 3
		)
		_ = CABasicAnimation(
			keyPath: "",
			values: values,
			duration: 0
		)
	}
}