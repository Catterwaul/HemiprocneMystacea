import HM
import XCTest

final class EnumeratedSequenceTestCase: XCTestCase {
	func test_mapElements() throws {
		do {
			_ = try
				["🚽", "🛁"]
				.enumerated()
				.mapElements{
					guard $0 == "🚽"
					else {
						struct Error: Swift.Error { }
						throw Error()
					}
				}
		}
		catch let error as EnumeratedSequenceError {
			XCTAssertEqual(error.index, 1)
		}
	}
}
