public extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
  
  func rounded(
    toNearestMultipleOf step: Self,
    roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
  ) -> Self {
    (self / step).rounded(roundingRule) * step
  }
}
