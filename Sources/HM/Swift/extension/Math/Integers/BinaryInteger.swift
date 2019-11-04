public extension BinaryInteger where Stride: SignedInteger  {
  static func makeMask(
    lowerBitIndex: Self = 0,
    upperBitIndex: Self
  ) -> Self {
    (lowerBitIndex...upperBitIndex).reduce(0) { mask, shift in
      1 << shift | mask
    }
  }

  func masked(
    lowerBitIndex: Self = 0,
    upperBitIndex: Self
  ) -> Self {
    self & .makeMask(
      lowerBitIndex: lowerBitIndex,
      upperBitIndex: upperBitIndex
    )
  }

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
