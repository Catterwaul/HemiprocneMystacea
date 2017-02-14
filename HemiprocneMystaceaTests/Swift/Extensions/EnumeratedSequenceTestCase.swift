import HM
import XCTest

final class EnumeratedSequenceTestCase: XCTestCase {
	func test_map() {
		do {
			_ = try
				["🚽", "🛁"]
				.enumerated()
				.map{
					guard $0 == "🚽"
					else {
						struct Error: Swift.Error {}
						throw Error()
					}
				}
		}
		catch let error as EnumeratedSequenceError {
			XCTAssertEqual(error.index, 1)
		}
		catch {XCTFail()}
	}
}
