infix operator ÷: MultiplicationPrecedence

public extension FloatingPoint {
  /// - Throws: `DivisionByZeroError<Self>`
  static func ÷ (numerator: Self, denominator: Self) throws -> Self {
    guard denominator != 0
    else { throw DivisionByZeroError(numerator: numerator) }

    return numerator / denominator
  }
  
  var isInteger: Bool { rounded() == self }
  
  func rounded(
    toNearestMultipleOf step: Self,
    roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
  ) -> Self {
    (self / step).rounded(roundingRule) * step
  }
}
