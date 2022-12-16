import simd

public extension SIMD2<Int32> {
  static func ..<(vector0: Self, vector1: Self) -> some Sequence<Self> {
    sequence(first: vector0) {
      let difference = vector1 &- $0
      guard abs(difference).max() > 1 else { return nil }
      return $0 &+ (vector1 &- $0).clamped(
        lowerBound: .init(repeating: -1),
        upperBound: .one
      )
    }
  }
}
