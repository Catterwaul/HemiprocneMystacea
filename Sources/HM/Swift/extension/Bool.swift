public extension Bool {
  ///- Returns:
  /// `false` for `0`,
  /// `true` for `1`,
  /// `nil` otherwise
  init?(_ int: Int) {
    switch int {
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
    guard let int = Int(binaryString) else {
      return nil
    }
    
    self.init(int)
  }
}

public extension Sequence where Element == () -> Bool {
  ///- Returns: whether all elements of the sequence evaluate to `bool`
  func containsOnly(_ bool: Bool) -> Bool {
    allSatisfy { getBool in bool == getBool() }
  }
}
