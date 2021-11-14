import HM
import XCTest

final class AsyncSequenceTestCase: XCTestCase {
  func test_collected() async throws {
    let array = ["🔥"]
    let collected = try await AnyAsyncSequence(array).collected
    XCTAssertEqual(collected, array)
  }
}
