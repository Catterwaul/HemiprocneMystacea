public extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min( max(limits.lowerBound, self), limits.upperBound )
  }
}
