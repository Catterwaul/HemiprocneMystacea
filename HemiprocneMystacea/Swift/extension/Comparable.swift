public extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    min( max(limits.lowerBound, self), limits.upperBound )
  }
}
