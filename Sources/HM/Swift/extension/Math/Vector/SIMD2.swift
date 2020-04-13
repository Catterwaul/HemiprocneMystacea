import CoreGraphics
import simd

public extension SIMD2 {
  init( _ scalars: (Scalar, Scalar) ) {
    self.init(scalars.0, scalars.1)
  }

  init<Float2: CommonVectorOperable>(_ float2: Float2)
  where Float2.Operand == Self {
    self = float2.convertedToOperand
  }
}

public extension SIMD2 where Scalar == CGFloat.NativeType {
//MARK:- Initializers
  init(_ x: CGFloat, _ y: CGFloat) {
    self.init(x.native, y.native)
  }

//MARK:- Methods

  func clamped(within bounds: CGRect) -> Self {
    simd.clamp(
      self,
      min: Self(bounds.minX, bounds.minY),
      max: Self(bounds.maxX, bounds.maxY)
    )
  }

  /// Distance to the closest point on the rectangle's boundary.
  /// - Note: Negative if inside the rectangle.
  func getSignedDistance(to rect: CGRect) -> Scalar {
    let distances =
      abs( self - Self(rect.center) )
      - Self(rect.size) / 2
    return
      all(sign(distances) .> 0)
      ? length(distances)
      : distances.max()
  }
}

public extension Collection where Element == SIMD2<Double> {
  var definiteIntegral: Double? {
    guard !isEmpty
    else { return nil }

    let definiteIntegral = consecutivePairs.reduce(0.0) { definiteIntegral, points in
      let delta = points.1 - points.0
      return
        definiteIntegral
        + delta.x * points.0.y
        + delta.x * delta.y / 2
    }

    return definiteIntegral
  }
}

public extension Collection where Element == (Double, Double) {
  var definiteIntegral: Double? {
    map( SIMD2.init(_:) ).definiteIntegral
  }
}
