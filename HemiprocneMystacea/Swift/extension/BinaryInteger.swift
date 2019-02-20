public extension BinaryInteger {
  /// *Divisbility*: when division by `divisor` results in a whole number.
  func divisible(divisor: Self) -> Bool {
    return self % divisor == 0
  }
}

public extension BinaryInteger where Stride: SignedInteger  {
  /// - Note: `nil` for negative numbers
  var factorial: Self? {
    switch self {
    case ..<0:
      return nil
    case 0...1:
      return 1
    default:
      return (2...self).reduce(1, *)
    }
  }
}
