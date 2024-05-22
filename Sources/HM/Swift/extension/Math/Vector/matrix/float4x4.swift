import simd
import Tuplé

public extension float4x4 {
  /// Reduces the precision of a `double4x4`.
  init(_ matrix: double4x4) {
    self.init(columns: matrix.columns)
  }

  /// Creates a new matrix with the specified columns.
  init(columns: Tuple4<SIMD4<some BinaryFloatingPoint>>) {
    self.init(columns: map(columns, SIMD4.init))
  }
}
