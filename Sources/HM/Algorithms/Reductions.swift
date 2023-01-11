import Algorithms

public extension Sequence {
  /// `reductions(into:)`, dropping the initial result.
  @inlinable func reductions<Result>(
    intoDropped initial: Result,
    _ transform: (inout Result, Element) throws -> Void
  ) rethrows -> [Result] {
    .init(try reductions(into: initial, transform).dropFirst())
  }

  /// `reductions`, dropping the initial result.
  @inlinable func reductions<Result>(
    dropping initial: Result,
    _ transform: (Result, Element) throws -> Result
  ) rethrows -> [Result] {
    try reductions(intoDropped: initial) { result, element in
      result = try transform(result, element)
    }
  }
}
