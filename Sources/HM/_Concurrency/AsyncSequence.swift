public extension AsyncSequence {
  var collected: [Element] {
    get async throws {
      try await .init(self)
    }
  }
}

// MARK: - Array

public extension Array {
  init<AsyncSequence: _Concurrency.AsyncSequence>(_ asyncSequence: AsyncSequence) async rethrows
  where AsyncSequence.Element == Element {
    self = try await asyncSequence.reduce(into: []) { $0.append($1) }
  }
}

// MARK: - Sequence

public extension Sequence {  
  func map<Transformed>(
    priority: TaskPriority? = nil,
    _ transform: @escaping (Element) async throws -> Transformed
  ) async rethrows -> [Transformed] {
    try await withThrowingTaskGroup(
      of: EnumeratedSequence<[Transformed]>.Element.self
    ) { group in
      for (offset, element) in enumerated() {
        group.addTask(priority: priority) {
          try await (offset, transform(element))
        }
      }
      
      return try await group.reduce(
        into: map { _ in nil } as [Transformed?]
      ) {
        $0[$1.offset] = $1.element
      } as! [Transformed]
    }
  }
}
