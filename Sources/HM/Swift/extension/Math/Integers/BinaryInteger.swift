public extension BinaryInteger {
  /// Store a pattern of `1`s and `0`s.
  /// - Parameter bitPattern: `true` becomes `1`; `false` becomes `0`.
  init?<BitPattern: Sequence>(bitPattern: BitPattern)
  where BitPattern.Element == Bool {
    guard let integer: Self = (
      bitPattern
      .lazy
      .map { $0 ? 1 : 0 }
      .reduce { $0 << 1 | $1 }
    )
    else { return nil }

    self = integer
  }
}

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
