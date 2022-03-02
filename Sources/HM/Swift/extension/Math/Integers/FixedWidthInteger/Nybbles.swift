public extension FixedWidthInteger where Self: _ExpressibleByBuiltinIntegerLiteral {
  var nybbles: Nybbles<Self> {
    get { .init(integer: self) }
    set { self = newValue.integer }
  }
}

/// The nybbles of an integer, from least significant to most.
public struct Nybbles<Integer: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral>: Hashable {
  fileprivate var integer: Integer
}

// MARK: - MutableCollection, RandomAccessCollection
extension Nybbles: MutableCollection, RandomAccessCollection {
  public typealias Index = Int

  public var startIndex: Index { 0 }
  public var endIndex: Index { Integer.bitWidth / 4 }

  public subscript(index: Index) -> Integer {
    get { integer >> (index * 4) & 0xF  }
    set {
      let index = index * 4
      integer &= ~(0xF << index)
      integer |= (newValue & 0xF) << index
    }
  }

  public func index(after index: Index) -> Index {
    index + 1
  }
}

// MARK: - RangeReplaceableCollection
extension Nybbles: RangeReplaceableCollection {
  /// All zeros.
  public init() {
    self.init(integer: 0)
  }
}

// MARK: - AdditiveArithmetic
extension Nybbles: AdditiveArithmetic {
  public static func - (lhs: Self, rhs: Self) -> Self {
    .init(integer: lhs.integer - rhs.integer)
  }
}

// MARK: - ExpressibleByIntegerLiteral
extension Nybbles: ExpressibleByIntegerLiteral {
  public init(integerLiteral integer: Integer) {
    self.integer = integer
  }
}

// MARK: - Numeric
extension Nybbles: Numeric {
  public init?<Source: BinaryInteger>(exactly source: Source) {
    guard let integer = Integer(exactly: source) else {
      return nil
    }

    self.init(integer: integer)
  }

  public var magnitude: Integer.Magnitude { integer.magnitude }

  public static func * (lhs: Self, rhs: Self) -> Self {
    .init(integer: lhs.integer * rhs.integer)
  }

  public static func *= (lhs: inout Self, rhs: Self) {
    lhs = lhs * rhs
  }
}

// MARK: - BinaryInteger
extension Nybbles: BinaryInteger {
  public static var isSigned: Bool { Integer.isSigned }

  public init?<Source: BinaryFloatingPoint>(exactly source: Source) {
    guard let integer = Integer(exactly: source) else {
      return nil
    }

    self.init(integer: integer)
  }

  public init<Source: BinaryInteger>(_ source: Source) {
    self.init(integer: .init(source))
  }

  public var words: Integer.Words { integer.words }
  public var bitWidth: Int { integer.bitWidth }
  public var trailingZeroBitCount: Int { integer.trailingZeroBitCount }

  public static func / (lhs: Self, rhs: Self) -> Self {
    .init(integer: lhs.integer / rhs.integer)
  }

  public static func /= (lhs: inout Self, rhs: Self) {
    lhs = lhs / rhs
  }

  public static func % (lhs: Self, rhs: Self) -> Self {
    .init(integer: lhs.integer % rhs.integer)
  }

  public static func %= (lhs: inout Self, rhs: Self) {
    lhs = lhs % rhs
  }

  public static func &= (lhs: inout Self, rhs: Self) {
    lhs = .init(integer: lhs.integer & rhs.integer)
  }

  public static func |= (lhs: inout Self, rhs: Self) {
    lhs = .init(integer: lhs.integer | rhs.integer)
  }

  public static func ^= (lhs: inout Self, rhs: Self) {
    lhs = .init(integer: lhs.integer ^ rhs.integer)
  }
}

// MARK: - FixedWidthInteger
extension Nybbles: FixedWidthInteger {
  public static var min: Self { .init(integer: .min) }
  public static var max: Self { .init(integer: .max) }

  public init(_truncatingBits bits: UInt) {
    self.init(integer: .init(_truncatingBits: bits))
  }

  public func addingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.addingReportingOverflow(rhs.integer)
    return (.init(integer: result.partialValue), result.overflow)
  }

  public func subtractingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.subtractingReportingOverflow(rhs.integer)
    return (.init(integer: result.partialValue), result.overflow)
  }

  public func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.multipliedReportingOverflow(by: rhs.integer)
    return (.init(integer: result.partialValue), result.overflow)
  }

  public func dividedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.dividedReportingOverflow(by: rhs.integer)
    return (.init(integer: result.partialValue), result.overflow)
  }

  public func remainderReportingOverflow(dividingBy rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.remainderReportingOverflow(dividingBy: rhs.integer)
    return (.init(integer: result.partialValue), result.overflow)
  }

  public func dividingFullWidth(_ dividend: (high: Self, low: Integer.Magnitude)) -> (quotient: Self, remainder: Self) {
    let result = integer.dividingFullWidth((dividend.high.integer, dividend.low))
    return (.init(integer: result.quotient), .init(integer: result.remainder))
  }

  public var nonzeroBitCount: Int { integer.nonzeroBitCount }
  public var leadingZeroBitCount: Int { integer.leadingZeroBitCount }
  public var byteSwapped: Self { .init(integer: integer.byteSwapped) }
  public static var bitWidth: Int { Integer.bitWidth }
}
