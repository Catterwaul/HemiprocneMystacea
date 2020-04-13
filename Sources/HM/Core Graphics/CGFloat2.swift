import CoreGraphics
import simd

public protocol CGFloat2 {
  init(x: Double, y: Double)

  var x: CGFloat { get }
  var y: CGFloat { get }
}

public extension CGFloat2 {
  private typealias Double2 = SIMD2<Double>

  static func + (float2_0: Self, float2_1: Self) -> Self {
    Self( Double2(float2_0) + Double2(float2_1) )
  }

  static func += (float2_0: inout Self, float2_1: Self) {
    float2_0 = float2_0 + float2_1
  }

  static func - (float2_0: Self, float2_1: Self) -> Self  {
    Self( Double2(float2_0) - Double2(float2_1) )
  }

  static func -= (float2_0: inout Self, float2_1: Self) {
    float2_0 = float2_0 - float2_1
  }

  static func * (float2: Self, float: CGFloat) -> Self {
    Self(Double2(float2) * float.native)
  }

  static func / (dividend: Self, divisor: Self) -> Self {
    Self( Double2(dividend) / Double2(divisor) )
  }

  static func / (float2: Self, float: CGFloat) -> Self {
    Self(Double2(float2) / float.native)
  }

  init<Float2: CGFloat2>(_ float2: Float2) {
    self.init(x: float2.x.native, y: float2.y.native)
  }

  init(_ double2: SIMD2<Double>) {
    self.init(x: double2.x, y: double2.y)
  }

  func clamped(within bounds: CGRect) -> Self {
    Self(
      clamp(
        Double2(self),
        min: Double2(x: bounds.minX, y: bounds.minY),
        max: Double2(x: bounds.maxX, y: bounds.maxY)
      )
    )
  }
}

extension CGPoint: CGFloat2 { }

extension CGVector: CGFloat2 {
  public init(x: Double, y: Double) {
    self.init(dx: x, dy: y)
  }

  public var x: CGFloat { dx }

  public var y: CGFloat { dy }
}

extension CGSize: CGFloat2 {
  public init(x: Double, y: Double) {
    self.init(width: x, height: y)
  }

  public var x: CGFloat { width }
  public var y: CGFloat { height }
}

public extension SIMD2 where Scalar == Double {
  init<Float2: CGFloat2>(_ float2: Float2) {
    self.init(x: float2.x, y: float2.y)
  }

  init(x: CGFloat, y: CGFloat) {
    self.init(x: x.native, y: y.native)
  }
}
