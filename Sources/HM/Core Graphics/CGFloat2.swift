import CoreGraphics
import simd

public protocol CGFloat2: CommonVectorOperable
where Operand == SIMD2<CGFloat.NativeType> {
  init(_: CGFloat.NativeType, _: CGFloat.NativeType)
}

//MARK: CommonOperable
public extension CGFloat2 {
  init(_ simd: Operand) {
    self.init(simd.x, simd.y)
  }
}

//MARK: CommonVectorOperable
public extension CGFloat2 {
  static var convertToOperandScalar: (CGFloat) -> Operand.Scalar { \.native }
}

extension CGPoint: CGFloat2 {
  public init(_ x: CGFloat.NativeType, _ y: CGFloat.NativeType) {
    self.init(x: x, y: y)
  }

  public var convertedToOperand: SIMD2<CGFloat.NativeType> { .init(x, y) }
}

extension CGSize: CGFloat2 {
  public init(_ width: CGFloat.NativeType, _ height: CGFloat.NativeType) {
    self.init(width: width, height: height)
  }

  public var convertedToOperand: SIMD2<CGFloat.NativeType> { .init(width, height) }
}

extension CGVector: CGFloat2 {
  public init(_ dx: CGFloat.NativeType, _ dy: CGFloat.NativeType) {
    self.init(dx: dx, dy: dy)
  }

  public var convertedToOperand: Operand { .init(dx, dy) }
}
