import HemiprocneMystacea
import XCTest

final class get_method_TestCase: XCTestCase {
	func test_2() {
		XCTAssertEqual(
			get_method(
				instance: 👼(),
				potentialMatches: (👼.🎄, 🎅.🎄)
			)?(),
			"☃️"
		)
		
		XCTAssertEqual(
			get_method(
				instance: 🎅(),
				potentialMatches: (👼.🎄, 🎅.🎄)
			)?(),
			🎤🙀
		)
	}
	
	func test_7() {
		XCTAssertEqual(
			get_method(
				instance: 👼(),
				potentialMatches: (
					🎅.🎄,
					🎅🏻.🎄,
					🎅🏼.🎄,
					🎅🏽.🎄,
					🎅🏾.🎄,
					🎅🏿.🎄,
					👼.🎄
				)
			)?(),
			"☃️"
		)
	}
}

private let 🎤🙀 = "You're gettin' nuttin' for Xmas!"

private protocol 🎄 {
	associatedtype 🎁
	func 🎄() -> 🎁
}

extension 🎄 {
	func 🎄() -> String {
		return 🎤🙀
	}
}

private struct 🎅: 🎄 {}
private struct 🎅🏻: 🎄 {}
private struct 🎅🏼: 🎄 {}
private struct 🎅🏽: 🎄 {}
private struct 🎅🏾: 🎄 {}
private struct 🎅🏿: 🎄 {}

private struct 👼: 🎄 {
	func 🎄() -> String {
		return "☃️"
	}
}
