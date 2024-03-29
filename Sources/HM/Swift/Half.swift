import Foundation

// This should fully conform to `BinaryFloatingPoint`
// but it would be a lot of work to implement that.
public struct Half: Hashable {
  public let bitPattern: UInt16
}

public extension Half {
  static let exponentBitCount = 5
  static let significandBitCount = 10
  
  init<Float: BinaryFloatingPoint>(_ float: Float) {
    let shiftedExponentBit = (
      float.sign == .plus
      ? 0
      : 1
    ) << (Half.exponentBitCount + Half.significandBitCount)
    
    let shiftedExponentBitPattern =
      Int(float.exponent + 0xF)
      << Half.significandBitCount
    
    let significandBitPattern =
      Int(float.significandBitPattern)
      >> (Float.significandBitCount - Half.significandBitCount)
    
    bitPattern = UInt16(
      shiftedExponentBit | shiftedExponentBitPattern | significandBitPattern
    )
  }
  
  init(_ integer: some BinaryInteger) {    
    self.init(Float(integer))
  }
  
  var exponent: Int { exponentBitPattern - 0xF }
  
  var exponentBitPattern: Int {
    (Int(bitPattern) >> Half.significandBitCount)
    & 0x1F
  }
  
  var sign: FloatingPointSign {
    bitPattern.leadingZeroBitCount > 0
    ? .plus
    : .minus
  }
  
  var significandBitPattern: Int { Int(bitPattern) & 0x3FF }
}

// MARK: Comparable
extension Half: Comparable {
  public static func < (half0: Half, half1: Half) -> Bool {
    Float(half0) < Float(half1)
  }
}

// MARK: ExpressibleByFloatLiteral
extension Half: ExpressibleByFloatLiteral {
  public init(floatLiteral float: Float) {
    self.init(float)
  }
}

// MARK: ExpressibleByIntegerLiteral
extension Half: ExpressibleByIntegerLiteral {
  public init(integerLiteral int32: Int32) {
    self.init(int32)
  }
}

// MARK: -
public extension BinaryFloatingPoint {
  init(_ half: Half) {
    self.init(
      sign: half.sign,
      exponentBitPattern: RawExponent(
        half.exponentBitPattern
        + Self.exponentBias - Half.exponentBias
      ),
      significandBitPattern: RawSignificand(
        half.significandBitPattern
        << (Self.significandBitCount - Half.significandBitCount)
      )
    )
  }
}
