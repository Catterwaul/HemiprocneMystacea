import HM
import XCTest

final class getMethodTestCase: XCTestCase {
	func test_2() {
		XCTAssertEqual(
			getMethod(
				instance: 👼(),
				potentialMatches: (👼.🎄, 🎅.🎄)
			)?(),
			"☃️"
		)
		
		XCTAssertEqual(
			getMethod(
				instance: 🎅(),
				potentialMatches: (👼.🎄, 🎅.🎄)
			)?(),
			🎤🙀
		)
	}
	
	func test_7() {
		XCTAssertEqual(
			getMethod(
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
	func 🎄() -> String { 🎤🙀 }
}

private struct 🎅: 🎄 { }
private struct 🎅🏻: 🎄 { }
private struct 🎅🏼: 🎄 { }
private struct 🎅🏽: 🎄 { }
private struct 🎅🏾: 🎄 { }
private struct 🎅🏿: 🎄 { }

private struct 👼: 🎄 {
	func 🎄() -> String { "☃️" }
}
