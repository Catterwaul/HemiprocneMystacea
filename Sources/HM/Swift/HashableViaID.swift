/// An `Identifiable` instance that uses its `id` for equality and hashability.
public protocol HashableViaID: Hashable, Identifiable { }

// MARK: - Equatable
public extension HashableViaID {
  static func == (equatable0: Self, equatable1: Self) -> Bool {
    equatable0.id == equatable1.id
  }
}

// MARK: - Hashable
public extension HashableViaID {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
