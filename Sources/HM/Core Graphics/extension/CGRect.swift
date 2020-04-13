import CoreGraphics

public extension CGRect {
//MARK:- Initializers

  init<Size: CommonOperable>(
    x: CGFloat, y: CGFloat,
    size: Size
  )
  where Size.Operand == SIMD2<CGFloat.NativeType> {
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
