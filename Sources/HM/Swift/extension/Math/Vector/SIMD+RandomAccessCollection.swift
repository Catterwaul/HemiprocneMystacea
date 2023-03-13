public extension SIMD where Self: RandomAccessCollection {
  var startIndex: Int { 0 }
  var endIndex: Int { scalarCount }
}

extension SIMD2: RandomAccessCollection { }
extension SIMD3: RandomAccessCollection { }
extension SIMD4: RandomAccessCollection { }
extension SIMD8: RandomAccessCollection { }
extension SIMD16: RandomAccessCollection { }
extension SIMD32: RandomAccessCollection { }
extension SIMD64: RandomAccessCollection { }
