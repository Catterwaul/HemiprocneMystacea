public extension AsyncSequence {
  var collected: [Element] {
    get async throws {
      try await reduce(into: []) { $0.append($1) }
    }
  }
}
