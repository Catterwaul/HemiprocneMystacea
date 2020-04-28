public extension Sequence where Element: FixedWidthInteger {
  func joined(radix: Int = 10) -> Int? {
    Int(
      map { String($0, radix: radix) } .joined(),
      radix: radix
    )
  }
}

//MARK: - PackedInteger

public enum PackedInteger<Storage: FixedWidthInteger> {
  public enum Error: Swift.Error {
    case notEnoughBits
  }

  /// Two integers packed into one.
  public struct Two<Integer0: FixedWidthInteger, Integer1: FixedWidthInteger> {
    /// The integer that two others are packed into.
    public let storage: Storage
  }
}

public extension PackedInteger.Two {
  /// - Parameters:
  ///   - integer0: Will be bit-shifted left of `integer1`.
  ///   - integer1: Stored directly.
  /// - Throws: `PackedInteger.Error.notEnoughBits` if they won't fit.
  init<Integer0: BinaryInteger, Integer1: BinaryInteger>(
    _ integer0: Integer0, _ integer1: Integer1
  ) throws {
    guard .bitWidth >= integer0.bitWidth + integer1.bitWidth
    else { throw PackedInteger.Error.notEnoughBits }

    storage =
      .init(truncatingIfNeeded:
        Storage.Magnitude(truncatingIfNeeded: integer0.bitPattern) << integer1.bitWidth
      )
      | .init(truncatingIfNeeded: integer1.bitPattern)
  }

  /// Unpack two integers.
  var unpacked: (Integer0, Integer1) {
    ( .init(truncatingIfNeeded: storage.bitPattern >> Integer1.bitWidth),
      .init(truncatingIfNeeded: storage)
    )
  }
}
