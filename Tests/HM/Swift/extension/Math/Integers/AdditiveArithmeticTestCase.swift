import HM
import XCTest

final class AdditiveArithmeticTestCase: XCTestCase {
	func test_sum() {
    XCTAssertEqual([1, 2, 3].sum, 6)
    XCTAssertEqual([0.5, 1, 1.5].sum, 3)
    XCTAssertNil([CGFloat]().sum)
	}
}
