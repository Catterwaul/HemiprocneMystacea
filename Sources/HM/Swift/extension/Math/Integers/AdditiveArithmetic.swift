public extension Sequence where Element: AdditiveArithmetic {
  var sum: Element? { reduce(+) }

  /// The differences between each successive pair of elements.
  /// - Note: Starts with the first element, as if the sequence were prepended with `zero`.
  var differences: some Sequence<Element> {
    chain(.zero, self).adjacentPairs().lazy.map { $1 - $0 }
  }
}
