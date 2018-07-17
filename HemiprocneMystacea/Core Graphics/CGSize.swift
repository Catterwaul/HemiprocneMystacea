import CoreGraphics

public extension CGSize {
  static func - (size0: CGSize, size1: CGSize) -> CGSize {
    return CGSize(
      width: size0.width - size1.width,
      height: size0.height - size1.height
    )
  }
  
  init(_ point: CGPoint) {
    self.init(
      width: point.x,
      height: point.y
    )
  }
}
