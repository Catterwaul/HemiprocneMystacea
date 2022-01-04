import HM
import XCTest

final class AsyncSequenceTestCase: XCTestCase {
  func test_collected() async throws {
    do {
      let array = ["🔥"]
      let collected: Array = try await AnyAsyncSequence(array).collected
      XCTAssertEqual(collected, array)
    }
    
    let set: Set = ["🔥"]
    let collected = try await AnyAsyncSequence(set).collected
    XCTAssertEqual(collected, set)
  }
  
  func test_map() async throws {
    let array = ["🔥"]

    func element(_ element: String) async throws -> String {
      element
    }
        
    do {
      let transformed = try await array.map(element)
      XCTAssertEqual(transformed, array)
    }
    
    do {
      let transformed = await array.map { try! await element($0) }
      XCTAssertEqual(transformed, array)
    }
  }
}
