public extension Numeric {
  var squared: Self { self * self }

  /// Raise this base to a `power`.
  func toThe<Power: UnsignedInteger>(_ power: Power) -> Self
  where Power.Stride: SignedInteger {
    power == 0
    ? 1
    : (1..<power).reduce(self) { result, _ in result * self }
  }
}

infix operator ÷: MultiplicationPrecedence

public extension FloatingPoint {
  /// - Throws: `DivisionByZeroError`
  static func ÷ (numerator: @autoclosure () -> Self, denominator: Self) throws -> Self {
    guard denominator != 0 else { throw DivisionByZeroError() }
    return numerator() / denominator
  }
}

public extension BinaryInteger {
  /// - Throws: `DivisionByZeroError<Self>`
  static func ÷ (numerator: @autoclosure () -> Self, denominator: Self) throws -> Self {
    guard denominator != 0 else { throw DivisionByZeroError() }
    return numerator() / denominator
  }
}

public struct DivisionByZeroError: Error { }
