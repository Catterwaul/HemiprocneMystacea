import AsyncAlgorithms
import HM
import Testing
import XCTest

final class AsyncSequenceTestCase: XCTestCase {
  @available(macOS 15, iOS 18, watchOS 11, *)
  @Test func forEach() async {
    var 🐱 = "🐱"
    await [()].async.forEach { 🐱 = "😺" }
    XCTAssertEqual(🐱, "😺")
  }

  func test_mapWithTaskGroup() async throws {
    let array = [0, 100, 200]

    @Sendable func delayed(_ adjustment: Int) async throws -> Int {
      try await Task.sleep(for: .milliseconds(array.last! - adjustment))
      return adjustment
    }
        
    do {
      let transformed = try await Array(array.mapWithTaskGroup(delayed))
      XCTAssertEqual(transformed, array)
    }
    
    // Utilize `rethrows` to eliminate `try`
    do {
      let transformed = await Array(array.mapWithTaskGroup { try! await delayed($0) })
      XCTAssertEqual(transformed, array)
    }
  }
  
  func test_compactMap() async throws {
    let array = ["0", nil, "2"]
    let compacted = Array(array.compacted())

    @Sendable func transform<Element>(_ element: Element?) async throws -> Element? {
      element
    }

    do {
      let transformed = try await array.compactMapWithTaskGroup(transform)
      XCTAssertEqual(transformed, compacted)
    }

    // Utilize `rethrows` to eliminate `try`
    do {
      let transformed = await array.compactMapWithTaskGroup { try! await transform($0) }
      XCTAssertEqual(transformed, compacted)
    }
  }
}
