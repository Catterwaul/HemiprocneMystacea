public extension SIMD where Self: RandomAccessCollection {
  var startIndex: Int { 0 }
  var endIndex: Int { scalarCount }
}

extension SIMD2: @retroactive RandomAccessCollection { }
extension SIMD3: @retroactive RandomAccessCollection { }
extension SIMD4: @retroactive RandomAccessCollection { }
extension SIMD8: @retroactive RandomAccessCollection { }
extension SIMD16: @retroactive RandomAccessCollection { }
extension SIMD32: @retroactive RandomAccessCollection { }
extension SIMD64: @retroactive RandomAccessCollection { }
