infix operator ÷: MultiplicationPrecedence

public extension FloatingPoint {
  var isInteger: Bool { rounded() == self }

  /// - Throws: `DivisionByZeroError<Bound>` when the range has zero magnitude.
  static func ÷ (numerator: Self, denominator: Self) throws -> Self {
    guard denominator != 0
    else { throw DivisionByZeroError(numerator: numerator) }

    return numerator / denominator
  }
}
