import CoreGraphics
import simd

public protocol CGFloat2: CommonVectorOperable {
  typealias SIMD = SIMD2<CGFloat.NativeType>

  init(x: CGFloat.NativeType, y: CGFloat.NativeType)

  var x: CGFloat { get }
  var y: CGFloat { get }
}

//MARK: CommonOperable
public extension CGFloat2 {
  var convertedToOperand: SIMD { .init(self) }
}

//MARK: CommonVectorOperable
public extension CGFloat2 {
  static var convertToOperandScalar: (CGFloat) -> SIMD.Scalar { \.native }
}

public extension CGFloat2 {
//MARK:- Initializers

  init(_ simd: SIMD) {
    self.init(x: simd.x, y: simd.y)
  }

  init<Float2: CGFloat2>(_ float2: Float2) {
    self.init(x: float2.x.native, y: float2.y.native)
  }

//MARK:- Methods

  func clamped(within bounds: CGRect) -> Self {
    Self(
      SIMD(self).clamped(within: bounds)
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
