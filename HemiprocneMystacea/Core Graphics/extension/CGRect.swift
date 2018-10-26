import CoreGraphics

public extension CGRect {
  var center: CGPoint {
    return CGPoint(x: midX, y: midY)
  }
  
  var max: CGPoint {
    return CGPoint(x: maxX, y: maxY)
  }
  
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
