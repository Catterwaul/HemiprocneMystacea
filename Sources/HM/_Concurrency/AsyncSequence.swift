import Collections

public extension Sequence where Element: Sendable {
  func mapWithTaskGroup<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws -> Transformed
  ) async rethrows -> [Transformed] {
    typealias ChildTaskResult = Heap<Int>.ElementValuePair<Transformed>
    return try await withThrowingTaskGroup(of: ChildTaskResult.self) { group in
      for (offset, element) in enumerated() {
        group.addTask(priority: priority) {
          .init(offset, try await transform(element))
        }
      }

      return try await group.reduce(into: Heap<ChildTaskResult>()) {
        $0.insert($1)
      }.sorted.map(\.value)
    }
  }
  
  func compactMapWithTaskGroup<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws -> Transformed?
  ) async rethrows -> [Transformed] {
    try await mapWithTaskGroup(transform).compactMap { $0 }
  }
}
