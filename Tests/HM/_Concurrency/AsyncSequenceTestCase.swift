import HM
import XCTest

final class AsyncSequenceTestCase: XCTestCase {  
  func test_map() async throws {
    let array = ["🔥"]

    @Sendable func element(_ element: String) async throws -> String {
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
  
  func test_compactMap() async throws {
    let array = ["0", nil, "2"]

    @Sendable func element(_ element: String?) async throws -> String? {
      element
    }

    do {
      let transformed = try await array.compactMap(element)
      XCTAssertEqual(transformed, ["0", "2"])
    }

    do {
      let transformed = await array.compactMap { try! await element($0) }
      XCTAssertEqual(transformed, ["0", "2"])
    }
  }
}
