import CoreGraphics
import simd

public protocol CGFloat2 {
  init(x: CGFloat.NativeType, y: CGFloat.NativeType)

  var x: CGFloat { get }
  var y: CGFloat { get }
}

public extension CGFloat2 {
  typealias SIMD = SIMD2<CGFloat.NativeType>

//MARK:- Operators

  static func + (float2_0: Self, float2_1: Self) -> Self {
    Self(float2_0 + float2_1 as SIMD)
  }

  static func + <Float2_1: CGFloat2>(float2_0: Self, float2_1: Float2_1) -> SIMD {
    operate(float2_0, +, float2_1)
  }

  static func += (float2_0: inout Self, float2_1: Self) {
    float2_0 = float2_0 + float2_1
  }

  static func - (float2_0: Self, float2_1: Self) -> Self  {
    Self(float2_0 - float2_1 as SIMD)
  }

  static func - <Float2_1: CGFloat2>(float2_0: Self, float2_1: Float2_1) -> SIMD {
    operate(float2_0, -, float2_1)
  }

  static func -= (float2_0: inout Self, float2_1: Self) {
    float2_0 = float2_0 - float2_1
  }

  static func * (float2: Self, float: CGFloat) -> Self {
    operate(float2, *, float)
  }

  static func / (dividend: Self, divisor: Self) -> Self  {
    Self(dividend / divisor as SIMD)
  }

  static func / <Divisor: CGFloat2>(dividend: Self, divisor: Divisor) -> SIMD {
    operate(dividend, /, divisor)
  }

  static func / (dividend: Self, divisor: CGFloat) -> Self {
    operate(dividend, /, divisor)
  }

  private static func operate<Float2_1: CGFloat2>(
    _ float2_0: Self,
    _ operate: (SIMD, SIMD) -> SIMD,
    _ float2_1: Float2_1
  ) -> SIMD {
    HM.operate(
      float2_0, operate, float2_1,
      convertOperand0: SIMD.init, convertOperand1: SIMD.init
    )
  }

  private static func operate(
    _ float2: Self,
    _ operate: (SIMD, SIMD.Scalar) -> SIMD,
    _ float: CGFloat
  ) -> Self {
    Self(
      operate(SIMD(float2), float.native)
    )
  }

//MARK:- Initializers

  init<Float2: CGFloat2>(_ float2: Float2) {
    self.init(x: float2.x.native, y: float2.y.native)
  }

  init(_ double2: SIMD) {
    self.init(x: double2.x, y: double2.y)
  }

//MARK:- Methods

  func clamped(within bounds: CGRect) -> Self {
    Self(
      clamp(
        SIMD(self),
        min: SIMD(x: bounds.minX, y: bounds.minY),
        max: SIMD(x: bounds.maxX, y: bounds.maxY)
      )
    )
  }
}

public extension SIMD2 where Scalar == CGFloat.NativeType {
//MARK:- Initializers

  init<Float2: CGFloat2>(_ float2: Float2) {
    self.init(x: float2.x, y: float2.y)
  }

  init(x: CGFloat, y: CGFloat) {
    self.init(x: x.native, y: y.native)
  }

//MARK:- Methods

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

extension CGPoint: CGFloat2 { }

extension CGVector: CGFloat2 {
  public init(x: CGFloat.NativeType, y: CGFloat.NativeType) {
    self.init(dx: x, dy: y)
  }

  public var x: CGFloat { dx }

  public var y: CGFloat { dy }
}

extension CGSize: CGFloat2 {
  public init(x: CGFloat.NativeType, y: CGFloat.NativeType) {
    self.init(width: x, height: y)
  }

  public var x: CGFloat { width }
  public var y: CGFloat { height }
}

func operate<
  Operand0, Operand1,
  ConvertedOperand0, ConvertedOperand1,
  Result
>(
  _ operand0: Operand0,
  _ operate: (ConvertedOperand0, ConvertedOperand1) -> Result,
  _ operand1: Operand1,
  convertOperand0: (Operand0) -> ConvertedOperand0,
  convertOperand1: (Operand1) -> ConvertedOperand1
) -> Result {
  operate( convertOperand0(operand0), convertOperand1(operand1) )
}
