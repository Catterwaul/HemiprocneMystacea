import CoreGraphics

public extension SIMD where Scalar: FloatingPoint {
  /// Convert integers to floating point vectors.
  init<Integer: BinaryInteger>(_ integers: Integer...) {
    self.init( integers.map(Scalar.init) )
  }
}

public extension CommonOperable
where Operand: SIMD, Operand.Scalar: FloatingPoint {
//MARK:- Operators
  static func + (operable0: Self, operable1: Self) -> Self {
    Self(operable0 + operable1 as Operand)
  }

  static func + <Operable1: CommonOperable>
  (operable0: Self, operable1: Operable1) -> Operand
  where Operand == Operable1.Operand {
    operate(operable0, +, operable1)
  }

  static func += (operable0: inout Self, operable1: Self) {
    operable0 = operable0 + operable1
  }

  static func - (operable0: Self, operable1: Self) -> Self {
    Self(operable0 - operable1 as Operand)
  }

  static func - <Operable1: CommonOperable>
  (operable0: Self, operable1: Operable1) -> Operand
  where Operand == Operable1.Operand {
    operate(operable0, -, operable1)
  }

  static func -= (operable0: inout Self, operable1: Self) {
    operable0 = operable0 - operable1
  }

  static func / (dividend: Self, divisor: Self) -> Self {
    Self(dividend / divisor as Operand)
  }

  static func / <Operable1: CommonOperable>
  (dividend: Self, divisor: Operable1) -> Operand
  where Operand == Operable1.Operand {
    operate(dividend, /, divisor)
  }
}

public extension CommonVectorOperable where Operand.Scalar: FloatingPoint {
  static func * (vector: Self, scalar: Scalar) -> Self {
    operate(vector, *, scalar)
  }

  static func / (dividend: Self, divisor: Scalar) -> Self {
    operate(dividend, /, divisor)
  }
}

public extension CommonVectorOperable where Operand == SIMD2<CGFloat.NativeType> {
  func clamped(within bounds: CGRect) -> Self {
    Self(
      Operand(self).clamped(within: bounds)
    )
  }
}
