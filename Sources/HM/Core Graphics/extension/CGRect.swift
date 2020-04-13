import CoreGraphics

public extension CGRect {
//MARK:- Initializers

  init<Size: CGFloat2>(
    x: CGFloat, y: CGFloat,
    size: Size
  ) {
    self.init(
      origin: CGPoint(x: x, y: y),
      size: CGSize(size)
    )
  }

//MARK:- Properties

  var center: CGPoint { .init(x: midX, y: midY) }

  var max: CGPoint { .init(x: maxX, y: maxY) }

  var points: Set<CGPoint> {
    [ [minX, maxY], [maxX, maxY],
      [minX, minY], [maxX, minY]
    ]
  }
}

import simd

public extension SIMD2 where Scalar == CGFloat.NativeType {
  /// Distance to the closest point on the rectangle.
  /// - Note: Negative if inside the rectangle.
  func getSignedDistance(to rect: CGRect) -> Double {
    let distances =
      abs( self - Self(rect.center) )
      - Self(rect.size) / 2
    return
      all(sign(distances) .> 0)
      ? length(distances)
      : distances.max()
  }
}
