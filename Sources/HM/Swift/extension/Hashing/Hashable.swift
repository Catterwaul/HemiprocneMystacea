public extension Hashable where Self: Identifiable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
