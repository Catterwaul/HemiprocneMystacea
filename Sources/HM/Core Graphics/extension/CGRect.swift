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

  var center: CGPoint { CGPoint(x: midX, y: midY) }

  var max: CGPoint { CGPoint(x: maxX, y: maxY) }

  var points: Set<CGPoint> {
    [ [minX, maxY], [maxX, maxY],
      [minX, minY], [maxX, minY]
    ]
  }
}
