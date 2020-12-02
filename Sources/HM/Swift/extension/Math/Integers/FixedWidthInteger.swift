public extension Sequence where Element: FixedWidthInteger {
  func joined(radix: Int = 10) -> Int? {
    Int(
      map { String($0, radix: radix) } .joined(),
      radix: radix
    )
  }
}

// MARK: - PackedInteger

/// Multiple integers packed into `Storage`.
public enum PackedInteger<Storage: FixedWidthInteger> {
  public enum Error: Swift.Error {
    /// `bitWidths`: The number of bits necessary to store each integer that was attemped to pack.
    case notEnoughBits(bitWidths: [Int])
  }

  /// Two integers packed into one.
  public struct Two<Integer0: FixedWidthInteger, Integer1: FixedWidthInteger> {
    /// - Parameter storage: The integer that two others are packed into.
    /// - Throws: `PackedInteger.Error.notEnoughBits`
    ///   if the two integer types won't fit into `Storage` together.
    public init(storage: Storage) throws {
      try Self.verifyBitsCanFit()
      self.storage = storage
    }

    /// The integer that two others are packed into.
    public let storage: Storage
  }

  /// Three integers packed into one.
  public struct Three<
    Integer0: FixedWidthInteger, Integer1: FixedWidthInteger, Integer2: FixedWidthInteger
  > {
    /// - Parameter storage: The integer that three others are packed into.
    /// - Throws: `PackedInteger.Error.notEnoughBits`
    ///   if the three integer types won't fit into `Storage` together.
    public init(storage: Storage) throws {
      try Self.verifyBitsCanFit()
      self.storage = storage
    }

    /// The integer that three others are packed into.
    public let storage: Storage
  }

  /// Four integers packed into one.
  public struct Four<
    Integer0: FixedWidthInteger, Integer1: FixedWidthInteger,
    Integer2: FixedWidthInteger, Integer3: FixedWidthInteger
  > {
    /// - Parameter storage: The integer that four others are packed into.
    /// - Throws: `PackedInteger.Error.notEnoughBits`
    ///   if the four integer types won't fit into `Storage` together.
    public init(storage: Storage) throws {
      try Self.verifyBitsCanFit()
      self.storage = storage
    }

    /// The integer that four others are packed into.
    public let storage: Storage
  }
}

private protocol PackedIntegerProtocol: Hashable {
  /// Same as `Storage`.
  /// [Nested generic types do not inherit associatedtypes like non-generic ones.](https://bugs.swift.org/browse/SR-12700)
  associatedtype _Storage: FixedWidthInteger

  /// The number of bits used for the underlying binary representations of each packed integer.
  static var bitWidths: [Int] { get }

  init(storage: _Storage) throws

  /// The integer that the others are packed into.
  var storage: _Storage { get }
}

extension PackedIntegerProtocol {
  /// - Throws: `PackedInteger<Storage>.Error.notEnoughBits`
  ///   if the desired integer types won't fit into `Storage` together.
  static func verifyBitsCanFit() throws {
    guard _Storage.bitWidth >= Self.bitWidths.sum! else {
      throw PackedInteger<_Storage>.Error.notEnoughBits(bitWidths: Self.bitWidths)
    }
  }

  /// - Parameter bitPatterns: Unsigned versions of the packed integers.
  /// - Throws: `PackedInteger<Storage>.Error.notEnoughBits`
  ///   if the desired integer types won't fit into `Storage` together.
  init(bitPatterns: _Storage.Magnitude...) throws {
    try self.init(storage:
      zip(bitPatterns, Self.bitWidths).reduce(into: 0) {
        ( packed,
          integer: (bitPattern: _Storage.Magnitude, bitWidth: Int)
        ) in
        packed <<= integer.bitWidth
        packed |= .init(truncatingIfNeeded: integer.bitPattern)
      }
    )
  }

  /// The untruncated bit patterns for the packed integers.
  var untruncatedBitPatterns: [_Storage.Magnitude] {
    Self.bitWidths.reversed().reduce(into: ([], storage.bitPattern)) {
      bitPatterns, bitWidth in
      bitPatterns.0.append(bitPatterns.1)
      bitPatterns.1 >>= bitWidth
    }.0.reversed()
  }
}

// MARK: - PackedInteger.Two
public extension PackedInteger.Two {
  /// - Parameters:
  ///   - integer0: Will be bit-shifted left of `integer1`.
  ///   - integer1: Stored directly.
  /// - Throws: `PackedInteger.Error.notEnoughBits`
  ///   if the two integer types won't fit into `Storage` together.
  init(_ integer0: Integer0, _ integer1: Integer1) throws {
    try self.init(bitPatterns:
      .init(truncatingIfNeeded: integer0.bitPattern),
      .init(truncatingIfNeeded: integer1.bitPattern)
    )
  }

  /// Unpack two integers.
  var unpacked: (Integer0, Integer1) {
    ( .init(truncatingIfNeeded: untruncatedBitPatterns[0]),
      .init(truncatingIfNeeded: untruncatedBitPatterns[1])
    )
  }
}

extension PackedInteger.Two: PackedIntegerProtocol {
  typealias _Storage = Storage

  static var bitWidths: [Int] {
    [Integer0.bitWidth, Integer1.bitWidth]
  }
}

// MARK: - PackedInteger.Three
public extension PackedInteger.Three {
  /// - Parameters:
  ///   - integer0: Will be bit-shifted left of `integer1`.
  ///   - integer1: Will be bit-shifted left of `integer2`.
  ///   - integer2: Stored directly.
  /// - Throws: `PackedInteger.Error.notEnoughBits`
  ///   if the three integer types won't fit into `Storage` together.
  init(
    _ integer0: Integer0, _ integer1: Integer1, _ integer2: Integer2
  ) throws {
    try self.init(bitPatterns:
      .init(truncatingIfNeeded: integer0.bitPattern),
      .init(truncatingIfNeeded: integer1.bitPattern),
      .init(truncatingIfNeeded: integer2.bitPattern)
    )
  }

  /// Unpack three integers.
  var unpacked: (Integer0, Integer1, Integer2) {
    ( .init(truncatingIfNeeded: untruncatedBitPatterns[0]),
      .init(truncatingIfNeeded: untruncatedBitPatterns[1]),
      .init(truncatingIfNeeded: untruncatedBitPatterns[2])
    )
  }
}

extension PackedInteger.Three: PackedIntegerProtocol {
  typealias _Storage = Storage

  static var bitWidths: [Int] {
    [Integer0.bitWidth, Integer1.bitWidth, Integer2.bitWidth]
  }
}

// MARK: - PackedInteger.Four
public extension PackedInteger.Four {
  /// - Parameters:
  ///   - integer0: Will be bit-shifted left of `integer1`.
  ///   - integer1: Will be bit-shifted left of `integer2`.
  ///   - integer2: Will be bit-shifted left of `integer3`.
  ///   - integer3: Stored directly.
  /// - Throws: `PackedInteger.Error.notEnoughBits`
  ///   if the three integer types won't fit into `Storage` together.
  init(
    _ integer0: Integer0, _ integer1: Integer1,
    _ integer2: Integer2, _ integer3: Integer3
  ) throws {
    try self.init(bitPatterns:
      .init(truncatingIfNeeded: integer0.bitPattern),
      .init(truncatingIfNeeded: integer1.bitPattern),
      .init(truncatingIfNeeded: integer2.bitPattern),
      .init(truncatingIfNeeded: integer3.bitPattern)
    )
  }

  /// Unpack four integers.
  var unpacked: (Integer0, Integer1, Integer2, Integer3) {
    ( .init(truncatingIfNeeded: untruncatedBitPatterns[0]),
      .init(truncatingIfNeeded: untruncatedBitPatterns[1]),
      .init(truncatingIfNeeded: untruncatedBitPatterns[2]),
      .init(truncatingIfNeeded: untruncatedBitPatterns[3])
    )
  }
}

extension PackedInteger.Four: PackedIntegerProtocol {
  typealias _Storage = Storage

  static var bitWidths: [Int] {
    [Integer0.bitWidth, Integer1.bitWidth, Integer2.bitWidth, Integer3.bitWidth]
  }
}
