import Spatial
import Tuplé

public extension float3x3 {
  /// Reduces the precision of a `double4x4`.
  init(_ matrix: double3x3) {
    self.init(columns: matrix.columns)
  }

  /// Creates a new matrix with the specified columns.
  init(columns: Tuple3<SIMD3<some BinaryFloatingPoint>>) {
    self.init(columns: map(columns)(SIMD3.init))
  }

  init(_ quaternion: simd_quatd) {
    self.init(double3x3.init(quaternion))
  }

  init(_ rotation: Rotation3D) {
    self.init(double3x3(rotation))
  }
}

public extension double3x3 {
  init(_ rotation: Rotation3D) {
    self.init(rotation.quaternion)
  }
}
