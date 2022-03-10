import Darwin

public extension SIMD4 {
  /// A four-element vector created by appending two scalars to a two-element vector.
  init(_ xy: SIMD2<Scalar>, _ z: Scalar, _ w: Scalar) {
    self.init(xy.x, xy.y, z, w)
  }

  /// A four-element vector created by appending one two-element vector to another.
  init(_ xy: SIMD2<Scalar>, _ zw: SIMD2<Scalar>) {
    self.init(lowHalf: xy, highHalf: zw)
  }
}

public extension SIMD4 where Scalar: BinaryFloatingPoint {
  /// Scale for `xyz`. Then a translation for `z` in the `w` position.
  static func orthographicProjection(xySize: SIMD2<Scalar>, near: Scalar, far: Scalar) -> Self {
    orthographicProjection(
      xyScale: 2 / xySize, // Doubled because xySize is twice the magnitude of the near/far clip plane extents.
      near: near,
      far: far
    )
  }

  /// Scale for `xyz`. Then a translation for `z` in the `w` position.
  /// - Parameters:
  ///   - fov: Horizontal field of view in radians.
  static func perpectiveProjection(fov: Scalar, near: Scalar, far: Scalar, aspectRatio: Scalar) -> Self {
    let yScale = 1 / Scalar(tan(Double(fov) / 2))
    let orthographicProjection = orthographicProjection(
      xyScale: [yScale / aspectRatio, yScale],
      near: near,
      far: far
    )
    return .init(orthographicProjection.lowHalf, orthographicProjection.highHalf * far)
  }

  /// Scale for `xyz`. Then a translation for `z` in the `w` position.
  private static func orthographicProjection(
    xyScale: SIMD2<Scalar>, near: Scalar, far: Scalar
  ) -> Self {
    .init(xyScale, [1, -near] / (far - near))
  }
}
