import HM
import XCTest

final class EllipsisTestCase: XCTestCase {
	func test() {
		class Class {
			var bool: Bool!
		}
		let `class` = Class()…{$0.bool = true}
		XCTAssertTrue(`class`.bool)
	}
	
	func test_output() {
		XCTAssertEqual(
			"🐢"…{$0 + "🔋"},
			"🐢🔋"
		)
		
		XCTAssertEqual(
			20…{$0 + 2}…String.init,
			"22"
		)
	}
}
