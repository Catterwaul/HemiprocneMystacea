extension BinaryFloatingPoint {
  static var exponentBias: Int {
    1 << (exponentBitCount - 1)
  }
}

protocol BinaryFloatingPoint_exponentBias {
  static var exponentBias: Int { get }
}

extension Double: BinaryFloatingPoint_exponentBias { }
extension Float: BinaryFloatingPoint_exponentBias { }
