public extension AsyncSequence {
  var collected: [Element] {
    get async throws { try await .init(self) }
  }
}
  
public extension AsyncSequence where Element: Hashable {
  var collected: Set<Element> {
    get async throws { try await .init(self) }
  }
}

// MARK: - Array

public extension Array {
  @available(
    swift, deprecated: 5.7,
    message: "Delete this and use AsyncAlgorithms!"
  )
  init<Elements: AsyncSequence>(_ asyncSequence: Elements) async rethrows
  where Elements.Element == Element {
    self = try await asyncSequence.reduce(into: []) { $0.append($1) }
  }
}

// MARK: - Set

public extension Set {
  init<Elements: AsyncSequence>(_ asyncSequence: Elements) async rethrows
  where Elements.Element == Element {
    self = try await asyncSequence.reduce(into: []) { $0.insert($1) }
  }
}

// MARK: - String

public extension String {
  init<Strings: AsyncSequence>(_ strings: Strings) async rethrows
  where Strings.Element == String {
    self = try await strings.reduce(into: .init()) { $0.append($1) }
  }
}

// MARK: - Sequence

public extension Sequence where Element: Sendable {
  func map<Transformed: Sendable>(
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
  
  func compactMap<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws -> Transformed?
  ) async rethrows -> [Transformed] {
    try await map(transform).compactMap { $0 }
  }
}
