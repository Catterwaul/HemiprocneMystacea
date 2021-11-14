public extension AsyncSequence {
  var collected: [Element] {
    get async throws {
      try await .init(self)
    }
  }
}

// MARK: - Array

public extension Array {
  init<AsyncSequence: _Concurrency.AsyncSequence>(_ asyncSequence: AsyncSequence) async throws
  where AsyncSequence.Element == Element {
    self = try await asyncSequence.reduce(into: []) { $0.append($1) }
  }
  
  init(_ taskGroup: TaskGroup<Element>) async {
    self = await taskGroup.reduce(into: []) { $0.append($1) }
  }
}

// MARK: - Sequence

public extension Sequence {
  func map<Transformed>(
    priority: TaskPriority? = nil,
    _ transform: @escaping (Element) async -> Transformed
  ) async -> [Transformed] {
    await withTaskGroup(of: Transformed.self) { group in
      for element in self {
        group.addTask(priority: priority) {
          await transform(element)
        }
      }
      
      return await .init(group)
    }
  }
  
  func map<Transformed>(
    priority: TaskPriority? = nil,
    _ transform: @escaping (Element) async throws -> Transformed
  ) async throws -> [Transformed] {
    try await withThrowingTaskGroup(of: Transformed.self) { group in
      for element in self {
        group.addTask(priority: priority) {
          try await transform(element)
        }
      }
      
      return try await .init(group)
    }
  }
}
