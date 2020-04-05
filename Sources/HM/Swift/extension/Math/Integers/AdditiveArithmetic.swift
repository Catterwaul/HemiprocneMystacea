public extension Sequence where Element: AdditiveArithmetic {
  var sum: Element? { reduce(+) }
}
