import HM
import XCTest

final class OptionalTestCase: XCTestCase {
	func test_assignedIfNil() {
		var bool: Bool? = nil
		XCTAssertTrue( bool.assignedIfNil {true} )
		XCTAssertTrue( bool.assignedIfNil {false} )
	}
}
