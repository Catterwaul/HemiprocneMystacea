import HM
import XCTest

final class AsyncSequenceTestCase: XCTestCase {
  func test_collected() async throws {
    let array = ["🔥"]
    let asyncSequence = AnyAsyncSequence(array)
    
    do {
      let collected = await asyncSequence.collected
      XCTAssertEqual(collected, array)
    }
    
    do {
      let collected = try await asyncSequence
        .map { element throws -> String in element }
        .collected
      
      XCTAssertEqual(collected, array)
    }
  }
}
