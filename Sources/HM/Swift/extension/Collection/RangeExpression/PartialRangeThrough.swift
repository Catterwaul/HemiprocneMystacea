public extension PartialRangeThrough where Bound: Strideable, Bound.Stride: SignedNumeric {
  @inlinable init(_ range: PartialRangeUpTo<Bound>) {
    self = ...range.upperBound.advanced(by: -1)
  }
}
