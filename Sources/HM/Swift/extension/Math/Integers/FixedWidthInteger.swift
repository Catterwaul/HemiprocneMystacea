public extension FixedWidthInteger {
  /// Pack two integers.
  /// - Parameters:
  ///   - integer0: Bit-shifted left of `integer1`.
  ///   - integer1: Stored directly.
  /// - Throws: `BitPackingError.notEnoughBits` if they won't fit.
  init<Integer0: BinaryInteger, Integer1: BinaryInteger>(
    _ integer0: Integer0, _ integer1: Integer1
  ) throws {
    guard .bitWidth >= integer0.bitWidth + integer1.bitWidth
    else { throw BitPackingError.notEnoughBits }

    self =
      Self(truncatingIfNeeded:
        Magnitude(truncatingIfNeeded: integer0.bitPattern) << integer1.bitWidth
      )
      | Self(truncatingIfNeeded: integer1.bitPattern)
  }

  /// Unpack two integers.
  /// - Throws: `BitPackingError.notEnoughBits` if they wouldn't have fit.
  func unpack<Integer0: FixedWidthInteger, Integer1: FixedWidthInteger>()
  throws -> (Integer0, Integer1) {
    guard .bitWidth >= Integer0.bitWidth + Integer1.bitWidth
    else { throw BitPackingError.notEnoughBits }

    return (
      Integer0(truncatingIfNeeded: bitPattern >> Integer1.bitWidth),
      Integer1(truncatingIfNeeded: self)
    )
  }
}

public enum BitPackingError: Error {
  case notEnoughBits
}

public extension Sequence where Element: FixedWidthInteger {
  func joined(radix: Int = 10) -> Int? {
    Int(
      map { String($0, radix: radix) } .joined(),
      radix: radix
    )
  }
}
