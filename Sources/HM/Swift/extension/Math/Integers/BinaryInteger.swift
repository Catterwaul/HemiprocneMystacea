public extension BinaryInteger {
  /// A bitmask within a range.
  /// - Parameter bitIndices: From least significant to most.
  static subscript<BitIndices: ClosedRangeConvertible>(mask bitIndices: BitIndices) -> Self
  where
    BitIndices.Bound: BinaryInteger,
    BitIndices.Bound.Stride: SignedInteger
  {
    bitIndices.closedRange.reduce(0) { mask, shift in
      1 << shift | mask
    }
  }

// MARK: - Initializers

  /// Store a pattern of `1`s and `0`s.
  /// - Parameter bitPattern: `true` becomes `1`; `false` becomes `0`.
  /// - Returns: nil if bitPattern has no elements.
  init?(bitPattern: some Sequence<Bool>) {
    guard let integer: Self = (
      bitPattern.reduce( { $0 ? 1 : 0 } ) { $0 << 1 | $1 }
    ) else { return nil }

    self = integer
  }

// MARK: - Subscripts

  /// The nybbles of this integer, from least significant to most.
  subscript(nybble index: Self) -> Self {
    get { self >> (index * 4) & 0xF }
    set {
      let index = index * 4
      let selfWithEmptyNybble = self & ~(0xF << index)
      self = selfWithEmptyNybble | (newValue & 0xF) << index
    }
  }

  /// A range of bits from this number.
  /// - Parameter bitIndices: From least significant to most.
  subscript<BitIndices: ClosedRangeConvertible>(mask bitIndices: BitIndices) -> Self
  where
    BitIndices.Bound: BinaryInteger,
    BitIndices.Bound.Stride: SignedInteger
  {
    self & Self[mask: bitIndices]
  }

// MARK: -

  /// The bits of this integer, in an unsigned variant.
  var bitPattern: Magnitude { .init(truncatingIfNeeded: self) }

  func modulo(_ divisor: Self) -> Self {
    let remainder = self % divisor
    return
      remainder >= 0
      ? remainder
      : remainder + divisor
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
