public extension IteratorProtocol {
  /// - Complexity: O(`index`)
  subscript(index: Int) -> Element? {
    IteratorSequence(self).dropFirst(index).first
  }

  /// `next`, without returning an element.
  mutating func iterate() {
    _ = next()
  }
}
