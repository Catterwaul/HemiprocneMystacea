public extension IteratorProtocol {
  /// - Complexity: O(`index`)
  subscript(index: Int) -> Element? {
    IteratorSequence(self).dropFirst(index).first
  }
}
