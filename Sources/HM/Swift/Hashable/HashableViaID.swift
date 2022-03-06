/// An `Identifiable` instance that uses its `id` for hashability.
public protocol HashableViaID: Hashable, Identifiable { }

// MARK: - Hashable
public extension HashableViaID {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
