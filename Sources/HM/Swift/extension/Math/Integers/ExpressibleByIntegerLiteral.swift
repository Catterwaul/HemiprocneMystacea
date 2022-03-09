public extension ExpressibleByIntegerLiteral where Self: Strideable, Stride: SignedInteger {
  /// *This many* iterations that produce no values.
  var iterations: LazyMapSequence<Range<Self>, Void> {
    (0..<self).lazy.map { _ in }
  }
}
