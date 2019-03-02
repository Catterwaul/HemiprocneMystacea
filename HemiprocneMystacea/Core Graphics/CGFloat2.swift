import CoreGraphics
import simd

public protocol CGFloat2 {
  init(x: Double, y: Double)

  var x: CGFloat { get }
  var y: CGFloat { get }
}

public extension CGFloat2 {
  static func + (float2_0: Self, float2_1: Self) -> Self {
    return Self( double2(float2_0) + double2(float2_1) )
  }

  static func += (float2_0: inout Self, float2_1: Self) {
    float2_0 = float2_0 + float2_1
  }

  static func - (float2_0: Self, float2_1: Self) -> Self  {
    return Self( double2(float2_0) - double2(float2_1) )
  }

  static func -= (float2_0: inout Self, float2_1: Self) {
    float2_0 = float2_0 - float2_1
  }

  static func * (float2: Self, float: CGFloat) -> Self {
    return Self(double2(float2) * float.native)
  }

  static func / (dividend: Self, divisor: Self) -> Self {
    return Self( double2(dividend) / double2(divisor) )
  }

  static func / (float2: Self, float: CGFloat) -> Self {
    return Self(double2(float2) / float.native)
  }

  init<Float2: CGFloat2>(_ float2: Float2) {
    self.init(x: float2.x.native, y: float2.y.native)
  }

  init(_ double2: double2) {
    self.init(x: double2.x, y: double2.y)
  }

  func clamped(within bounds: CGRect) -> Self {
    return Self(
      clamp(
        double2(self),
        min: double2(x: bounds.minX, y: bounds.minY),
        max: double2(x: bounds.maxX, y: bounds.maxY)
      )
    )
  }
}

extension CGPoint: CGFloat2 { }

extension CGVector: CGFloat2 {
  public init(x: Double, y: Double) {
    self.init(dx: x, dy: y)
  }

  public var x: CGFloat {
    return dx
  }

  public var y: CGFloat {
    return dy
  }
}

extension CGSize: CGFloat2 {
  public init(x: Double, y: Double) {
    self.init(width: x, height: y)
  }

  public var x: CGFloat {
    return width
  }

  public var y: CGFloat {
    return height
  }
}

public extension double2 {
  init<Float2: CGFloat2>(_ float2: Float2) {
    self.init(x: float2.x, y: float2.y)
  }

  init(x: CGFloat, y: CGFloat) {
    self.init(x: x.native, y: y.native)
  }
}
