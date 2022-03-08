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
  static func orthographic(xySize: SIMD2<Scalar>, near: Scalar, far: Scalar) -> Self {
    clipSpaceProjection(
      xyScale: 2 / xySize, // Doubled because xySize is twice the magnitude of the near/far clip plane extents.
      zScale: 1,
      near: near,
      far: far
    )
  }

  /// Scale for `xyz`. Then a translation for `z` in the `w` position.
  static func perpective(fov: Scalar, near: Scalar, far: Scalar, aspectRatio: Scalar) -> Self {
    let yScale = 1 / Scalar(tan(Double(fov) / 2))
    return clipSpaceProjection(
      xyScale: [yScale / aspectRatio, yScale],
      zScale: far,
      near: near,
      far: far
    )
  }

  /// Scale for `xyz`. Then a translation for `z` in the `w` position.
  private static func clipSpaceProjection(
    xyScale: SIMD2<Scalar>, zScale: Scalar, near: Scalar, far: Scalar
  ) -> Self {
    let zScale = zScale / (far - near)
    return .init(xyScale, zScale, -near * zScale)
  }
}
