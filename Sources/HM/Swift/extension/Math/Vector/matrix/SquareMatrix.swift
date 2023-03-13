import simd

public protocol SquareSIMDFloatingPointMatrix {
  associatedtype Vector: SIMD & Collection<Vector.Scalar>
  where Vector.Scalar: FloatingPoint

  init(_ columns: [Vector])
}

public extension SquareSIMDFloatingPointMatrix {
  init(column: Vector, row: Vector) {
    self.init(row.map { column * $0 })
  }
}

extension matrix_float2x2: SquareSIMDFloatingPointMatrix { }
extension matrix_float3x3: SquareSIMDFloatingPointMatrix { }
extension matrix_float4x4: SquareSIMDFloatingPointMatrix { }
extension matrix_double2x2: SquareSIMDFloatingPointMatrix { }
extension matrix_double3x3: SquareSIMDFloatingPointMatrix { }
extension matrix_double4x4: SquareSIMDFloatingPointMatrix { }
