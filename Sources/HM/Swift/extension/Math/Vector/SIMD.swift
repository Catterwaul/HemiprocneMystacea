// TODO: Use macros to support all SIMD types.
public extension SIMD where Scalar: SIMDScalar {
  /// The ".xy" of a vector.
  ///
  /// - Note: Acts as a default for the subscript that accesses elements based on a `SIMD2<Index>`,
  ///   and adds write capability to it.
  subscript(index0: Int = 0, index1: Int = 1) -> SIMD2<Scalar> {
    get { self[[index0, index1]] }
    set {
      for index in [index0, index1].indexed() {
        self[index.element] = newValue[index.index]
      }
    }
  }

  /// The ".xyz" of a vector.
  ///
  /// - Note: Acts as a default for the subscript that accesses elements based on a `SIMD3<Index>`,
  ///   and adds write capability to it.
  subscript(index0: Int = 0, index1: Int = 1, index2: Int = 2) -> SIMD3<Scalar> {
    get { self[[index0, index1, index2]] }
    set {
      for index in [index0, index1, index2].indexed() {
        self[index.element] = newValue[index.index]
      }
    }
  }
}

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
