public protocol BackedByInteger: FixedWidthInteger {
  associatedtype Integer: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral

  init(_ integer: Integer)
  var integer: Integer { get }
}

// MARK: - AdditiveArithmetic
extension BackedByInteger {
  public static func - (lhs: Self, rhs: Self) -> Self {
    .init(lhs.integer - rhs.integer)
  }
}

// MARK: - ExpressibleByIntegerLiteral
extension BackedByInteger {
  public init(integerLiteral integer: Integer) {
    self.init(integer)
  }
}

// MARK: - Numeric
extension BackedByInteger {
  public init?<Source: BinaryInteger>(exactly source: Source) {
    guard let integer = Integer(exactly: source) else {
      return nil
    }

    self.init(integer)
  }

  public var magnitude: Integer.Magnitude { integer.magnitude }

  public static func * (lhs: Self, rhs: Self) -> Self {
    .init(lhs.integer * rhs.integer)
  }

  public static func *= (lhs: inout Self, rhs: Self) {
    lhs = lhs * rhs
  }
}

// MARK: - BinaryInteger
extension BackedByInteger {
  public static var isSigned: Bool { Integer.isSigned }

  public init?<Source: BinaryFloatingPoint>(exactly source: Source) {
    guard let integer = Integer(exactly: source) else {
      return nil
    }

    self.init(integer)
  }

  public init<Source: BinaryInteger>(_ source: Source) {
    self.init(Integer(source))
  }

  public var words: Integer.Words { integer.words }
  public var bitWidth: Int { integer.bitWidth }
  public var trailingZeroBitCount: Int { integer.trailingZeroBitCount }

  public static func / (lhs: Self, rhs: Self) -> Self {
    .init(lhs.integer / rhs.integer)
  }

  public static func /= (lhs: inout Self, rhs: Self) {
    lhs = lhs / rhs
  }

  public static func % (lhs: Self, rhs: Self) -> Self {
    .init(lhs.integer % rhs.integer)
  }

  public static func %= (lhs: inout Self, rhs: Self) {
    lhs = lhs % rhs
  }

  public static func &= (lhs: inout Self, rhs: Self) {
    lhs = .init(lhs.integer & rhs.integer)
  }

  public static func |= (lhs: inout Self, rhs: Self) {
    lhs = .init(lhs.integer | rhs.integer)
  }

  public static func ^= (lhs: inout Self, rhs: Self) {
    lhs = .init(lhs.integer ^ rhs.integer)
  }
}

// MARK: - FixedWidthInteger
extension BackedByInteger {
  public static var min: Self { .init(.min) }
  public static var max: Self { .init(.max) }

  public init(_truncatingBits bits: UInt) {
    self.init(.init(_truncatingBits: bits))
  }

  public func addingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.addingReportingOverflow(rhs.integer)
    return (.init(result.partialValue), result.overflow)
  }

  public func subtractingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.subtractingReportingOverflow(rhs.integer)
    return (.init(result.partialValue), result.overflow)
  }

  public func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.multipliedReportingOverflow(by: rhs.integer)
    return (.init(result.partialValue), result.overflow)
  }

  public func dividedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.dividedReportingOverflow(by: rhs.integer)
    return (.init(result.partialValue), result.overflow)
  }

  public func remainderReportingOverflow(dividingBy rhs: Self) -> (partialValue: Self, overflow: Bool) {
    let result = integer.remainderReportingOverflow(dividingBy: rhs.integer)
    return (.init(result.partialValue), result.overflow)
  }

  public func dividingFullWidth(_ dividend: (high: Self, low: Integer.Magnitude)) -> (quotient: Self, remainder: Self) {
    let result = integer.dividingFullWidth((dividend.high.integer, dividend.low))
    return (.init(result.quotient), .init(result.remainder))
  }

  public var nonzeroBitCount: Int { integer.nonzeroBitCount }
  public var leadingZeroBitCount: Int { integer.leadingZeroBitCount }
  public var byteSwapped: Self { .init(integer.byteSwapped) }
  public static var bitWidth: Int { Integer.bitWidth }
}
