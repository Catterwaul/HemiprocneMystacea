import AsyncAlgorithms
import HM
import Testing

struct AsyncSequenceTests {
  @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
  @Test func forEach() async {
    var 🐱 = "🐱"
    await [()].async.forEach { 🐱 = "😺" }
    #expect(🐱 == "😺")
  }

  @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
  @Test func mapWithTaskGroup() async throws {
    let array = [0, 100, 200]

    @Sendable func delayed(_ adjustment: Int) async throws -> Int {
      try await Task.sleep(for: .milliseconds(array.last! - adjustment))
      return adjustment
    }


    do {
      let transformed = try await Array(array.mapWithThrowingTaskGroup(delayed))
      #expect(transformed == array)
    }
    
    // Utilize `rethrows` to eliminate `try`
    do {
      let transformed = await Array(array.mapWithTaskGroup { try! await delayed($0) })
      #expect(transformed == array)
    }
  }
  
  @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
  @Test func compactMap() async throws {
    let array = ["0", nil, "2"]
    let compacted = Array(array.compacted())

    @Sendable func transform<Element>(_ element: Element?) async throws -> Element? {
      element
    }

    do {
      let transformed = try await array.compactMapWithTaskGroup(transform)
      #expect(transformed == compacted)
    }

    // Utilize `rethrows` to eliminate `try`
    do {
      let transformed = await array.compactMapWithTaskGroup { try! await transform($0) }
      #expect(transformed == compacted)
    }
  }
}
