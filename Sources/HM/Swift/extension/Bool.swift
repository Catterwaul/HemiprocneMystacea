public extension Bool {
  ///- Returns:
  /// `false` for `0`,
  /// `true` for `1`,
  /// `nil` otherwise
  init?<Integer: ExpressibleByIntegerLiteral & Equatable>(bit: Integer) {
    switch bit {
    case 0:
      self = false
    case 1:
      self = true
    default:
      return nil
    }
  }

  ///- Returns:
  /// `false` for `"0"`,
  /// `true` for `"1"`,
  /// `nil` otherwise
  init?(binaryString: String) {
    guard let bit = Int(binaryString) else {
      return nil
    }
    
    self.init(bit: bit)
  }

  /// Modify a value if `true`.
  /// - Returns: An unmodified value, when false.
  @inlinable func reduce<Result>(
    _ resultWhenFalse: Result,
    _ makeResult: (_ resultWhenFalse: Result) throws -> Result
  ) rethrows -> Result {
    self
    ? try makeResult(resultWhenFalse)
    : resultWhenFalse
  }
}

public extension Sequence where Element == () -> Bool {
  ///- Returns: whether all elements of the sequence evaluate to `bool`
  func containsOnly(_ bool: Bool) -> Bool {
    allSatisfy { getBool in bool == getBool() }
  }
}
