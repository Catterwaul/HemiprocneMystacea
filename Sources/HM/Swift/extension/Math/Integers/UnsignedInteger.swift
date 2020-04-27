public extension UnsignedInteger {
  /// The digits that make up this number.
  /// - Parameter radix: The base the result will use.
  func digits(radix: Self = 10) -> [Self] {
    sequence(state: self) { quotient in
      guard quotient > 0
      else { return nil }

      let division = quotient.quotientAndRemainder(dividingBy: radix)
      quotient = division.quotient
      return division.remainder
    }
    .reversed()
  }
}
