public extension BinaryInteger {
  /// *Divisbility*: when division by `divisor` results in a whole number.
  func divisible(divisor: Self) -> Bool {
    return self % divisor == 0
  }
}
