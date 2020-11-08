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

// Division isn't actually found in `Numeric`,
// but it does seem to be found in all the important protocols that inherit from it.
public struct DivisionByZeroError<Numerator: Swift.Numeric>: Error {
  public let numerator: Numerator

  public init(numerator: Numerator) {
    self.numerator = numerator
  }
}

extension DivisionByZeroError: Equatable where Numerator: Equatable { }
extension DivisionByZeroError: Hashable where Numerator: Hashable { }
