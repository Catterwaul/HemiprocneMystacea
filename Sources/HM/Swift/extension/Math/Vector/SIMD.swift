public extension SIMD where Scalar: FloatingPoint {
  /// Convert integers to floating point vectors.
  init<Integer: BinaryInteger>(_ integers: Integer...) {
    self.init( integers.map(Scalar.init) )
  }
}
