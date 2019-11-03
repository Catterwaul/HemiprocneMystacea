public extension Numeric {
  var squared: Self { self * self }
}

// Division isn't actually found in `Numeric`,
// but it does seem to be found in all the important protocols that inherit from it.
public struct DivisionByZeroError<Numerator>: Error {
  public let numerator: Numerator
  
  public init(numerator: Numerator) {
    self.numerator = numerator
  }
}
