import CoreGraphics

extension CGPoint: ExpressibleByArrayLiteral {
  public init(arrayLiteral floats: CGFloat...) {
    self.init(x: floats[0], y: floats[1])
  }
}
extension CGPoint: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}
