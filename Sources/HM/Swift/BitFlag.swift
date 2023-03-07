/// A representation of a single bit "flag".
public struct BitFlag<RawValue: BinaryInteger & _ExpressibleByBuiltinIntegerLiteral> {
  public let rawValue: RawValue

  public init?(rawValue: RawValue) {
    guard
      rawValue != 0,
      rawValue & (rawValue - 1) == 0
    else { return nil }

    self.rawValue = rawValue
  }
}

// MARK: - Equatable
extension BitFlag: Equatable { }

// MARK: - ExpressibleByIntegerLiteral
extension BitFlag: ExpressibleByIntegerLiteral {
  public init(integerLiteral flagIndex: RawValue) {
    self.init(rawValue: 1 << flagIndex)!
  }
}

// MARK: - RawRepresentable
extension BitFlag: RawRepresentable { }
