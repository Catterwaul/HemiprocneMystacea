public extension Sequence where Element: Sendable {
  func mapWithTaskGroup<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws -> Transformed
  ) async rethrows -> [Transformed] {
    try await withThrowingTaskGroup(
      of: EnumeratedSequence<[Transformed]>.Element.self
    ) { group in
      for (offset, element) in enumerated() {
        group.addTask(priority: priority) {
          (offset, try await transform(element))
        }
      }
      
      return try await group.reduce(
        into: map { _ in nil } as [Transformed?]
      ) {
        $0[$1.offset] = $1.element
      } as! [Transformed]
    }
  }
  
  func compactMapWithTaskGroup<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws -> Transformed?
  ) async rethrows -> [Transformed] {
    try await mapWithTaskGroup(transform).compactMap { $0 }
  }
}
