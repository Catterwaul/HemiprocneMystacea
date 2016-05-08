import HemiprocneMystacea
import XCTest

final class NSByteCountFormatterTestCaseTestCase: XCTestCase {
	func testString() {
		let formatter = NSByteCountFormatter(includesUnit: true)
		XCTAssertEqual(
			[ 100,
				6565,
				4_000_000
			].map{formatter.String($0)},
			[ "100 bytes",
				"7 KB",
				"4 MB"
			]
		)
	}
}