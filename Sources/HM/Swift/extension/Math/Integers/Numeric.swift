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

public enum ConcreteNumeric<Numeric: Swift.Numeric> {
  // Division isn't actually found in `Numeric`,
  // but it does seem to be found in all the important protocols that inherit from it.
  public struct DivisionByZeroError: Error {
    public let numerator: Numeric

    public init(numerator: Numeric) {
      self.numerator = numerator
    }
  }
}
