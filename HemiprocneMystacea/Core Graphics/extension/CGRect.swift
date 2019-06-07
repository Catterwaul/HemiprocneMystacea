import CoreGraphics

public extension CGRect {
  var center: CGPoint { CGPoint(x: midX, y: midY) }
  
  var max: CGPoint { CGPoint(x: maxX, y: maxY) }
  
//MARK: init
  init<Size: CGFloat2>(
    x: CGFloat, y: CGFloat,
    size: Size
  ) {
    self.init(
      origin: CGPoint(x: x, y: y),
      size: CGSize(size)
    )
  }
}
