import HM
import XCTest

final class EnumeratedSequenceTestCase: XCTestCase {
  func test_mapElements() throws {
    do {
      _ = try
        ["🚽", "🛁"]
        .enumerated()
        .mapElements {
          guard $0 == "🚽" else { throw AnyError() }
        }
    } catch let error as EnumeratedSequence<[String]>.Error {
      XCTAssertEqual(error.index, 1)
    }
  }
}
