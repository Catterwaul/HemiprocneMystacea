/// - Remark: option+
infix operator ±: AdditionPrecedence

public extension AdditiveArithmetic where Self: Comparable {
  /// `bound - range...bound + range`
  /// - Remark: option+
  static func ± (bound: Self, range: Self) -> ClosedRange<Self> {
    bound - range...bound + range
  }
}

public extension AdditiveArithmetic where Self: ExpressibleByIntegerLiteral {
  static var fibonacciSequence: some Sequence<Self> {
    sequence(state: (0 as Self, 1 as Self)) { numbers in
      defer { numbers = (numbers.1, numbers.0 + numbers.1) }
      return numbers.0
    }
  }
}

public extension Sequence where Element: AdditiveArithmetic {
  var sum: Element? { reduce(+) }

  /// The differences between each successive pair of elements.
  /// - Note: Starts with the first element, as if the sequence were prepended with `zero`.
  var differences: some Sequence<Element> {
    chain(.zero, self).adjacentPairs().lazy.map { $1 - $0 }
  }
}
