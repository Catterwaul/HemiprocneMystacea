import CoreGraphics

public extension SIMD where Scalar: Numeric {
  var squareMagnitude: Scalar { dot(self) }
  
  /// The dot product.
  func dot(_ vector: Self) -> Scalar {
    indices.lazy.map { self[$0] * vector[$0] }.sum!
  }
}

public extension SIMD where Scalar: FixedWidthInteger {
  static func ...(vector0: Self, vector1: Self) -> some Sequence<Self> {
    sequence(first: vector0) {
      guard $0 != vector1 else { return nil }

      return $0 &+ (vector1 &- $0).clamped(
        lowerBound: .init(repeating: -1),
        upperBound: .init(repeating: 1)
      )
    }
  }
}

public extension SIMD where Scalar: FloatingPoint {
  /// Convert integers to floating point vectors.
  init<Integer: BinaryInteger>(_ integers: Integer...) {
    self.init(integers.map(Scalar.init))
  }
}

public extension CommonOperable
where Operand: SIMD, Operand.Scalar: FloatingPoint {
  static func + <Result: CommonOperable<Operand>>
  (operable0: Self, operable1: some CommonOperable<Operand>) -> Result {
    operate(operable0, +, operable1)
  }

  static func + (operable0: Self, operable1: Self) -> Self {
    operate(operable0, +, operable1)
  }

  static func += (operable0: inout Self, operable1: some CommonOperable<Operand>) {
    operable0 = operable0 + operable1
  }

// MARK: -

  static func - <Result: CommonOperable<Operand>>
  (operable0: Self, operable1: some CommonOperable<Operand>) -> Result {
    operate(operable0, -, operable1)
  }

  static func - (operable0: Self, operable1: Self) -> Self {
    operate(operable0, -, operable1)
  }

  static func -= (operable0: inout Self, operable1: some CommonOperable<Operand>) {
    operable0 = operable0 - operable1
  }

// MARK: -

  static func / <Result: CommonOperable<Operand>>
  (dividend: Self, divisor: some CommonOperable<Operand>) -> Result {
    operate(dividend, /, divisor)
  }

  static func / (dividend: Self, divisor: Self) -> Self {
    operate(dividend, /, divisor)
  }

  static func /= (dividend: inout Self, divisor: some CommonOperable<Operand>) {
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
