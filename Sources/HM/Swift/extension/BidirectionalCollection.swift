public extension BidirectionalCollection where Element: Equatable {
  /// A subsequence starting at the last occurrence of `element.`
  ///
  ///- Returns: nil if `element` isn't present.
  func suffix(from element: Element) -> SubSequence? {
    lastIndex(of: element).map(suffix)
  }
}
