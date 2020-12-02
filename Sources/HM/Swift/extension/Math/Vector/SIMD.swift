import CoreGraphics

public extension SIMD where Scalar: FloatingPoint {
  /// Convert integers to floating point vectors.
  init<Integer: BinaryInteger>(_ integers: Integer...) {
    self.init(integers.map(Scalar.init))
  }
}

public extension CommonOperable
where Operand: SIMD, Operand.Scalar: FloatingPoint {
  static func + <Operable1: CommonOperable, Result: CommonOperable>
  (operable0: Self, operable1: Operable1) -> Result
  where Operand == Operable1.Operand, Operand == Result.Operand {
    operate(operable0, +, operable1)
  }

  static func + (operable0: Self, operable1: Self) -> Self {
    operate(operable0, +, operable1)
  }

  static func += <Operable1: CommonOperable>
  (operable0: inout Self, operable1: Operable1)
  where Operand == Operable1.Operand {
    operable0 = operable0 + operable1
  }

// MARK: -

  static func - <Operable1: CommonOperable, Result: CommonOperable>
  (operable0: Self, operable1: Operable1) -> Result
  where Operand == Operable1.Operand, Operand == Result.Operand {
    operate(operable0, -, operable1)
  }

  static func - (operable0: Self, operable1: Self) -> Self {
    operate(operable0, -, operable1)
  }

  static func -= <Operable1: CommonOperable>
  (operable0: inout Self, operable1: Operable1)
  where Operand == Operable1.Operand {
    operable0 = operable0 - operable1
  }

// MARK: -

  static func / <Divisor: CommonOperable, Result: CommonOperable>
  (dividend: Self, divisor: Divisor) -> Result
  where Operand == Divisor.Operand, Operand == Result.Operand {
    operate(dividend, /, divisor)
  }

  static func / (dividend: Self, divisor: Self) -> Self {
    operate(dividend, /, divisor)
  }

  static func /= <Divisor: CommonOperable>
  (dividend: inout Self, divisor: Divisor)
  where Operand == Divisor.Operand {
    dividend = dividend / divisor
  }
}

public extension CommonOperable where Operand == SIMD2<CGFloat.NativeType> {
  func clamped<Result: CommonOperable>(within bounds: CGRect) -> Result
  where Operand == Result.Operand {
    performMethod(Operand.clamped(within:), bounds)
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
  /// Distance to the closest point on the rectangle's boundary.
  /// - Note: Negative if inside the rectangle.
  func signedDistance(to rect: CGRect) -> CGFloat.NativeType {
    performMethod(Operand.signedDistance(to:), rect)
  }
}
