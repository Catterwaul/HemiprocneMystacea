import simd

public extension SIMD3 where Scalar == Double {
  /// A random color.
  /// - Parameters:
  ///   - saturation: Normalized. 0...1
  ///   - value: The value of the brightest color channel.
  static func randomColor(saturation: Scalar, value: Scalar) -> Self {
    mix(
      .init(repeating: value),
      .init([value, .random(in: 0...value), 0].shuffled()),
      t: saturation
    )
  }
}
