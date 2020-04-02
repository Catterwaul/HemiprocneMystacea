public extension SIMD where Scalar: FloatingPoint {
  init<Integer: BinaryInteger>(_ integers: Integer...) {
    self.init( integers.map(Scalar.init) )
  }
}
