public extension Bool {
  ///- Returns:
  /// `false` for `0`,
  /// `true` for `1`,
  /// `nil` otherwise
  init?(bit: some ExpressibleByIntegerLiteral & Equatable) {
    switch bit {
    case 0: self = false
    case 1: self = true
    default: return nil
    }
  }

  ///- Returns:
  /// `false` for `"0"`,
  /// `true` for `"1"`,
  /// `nil` otherwise
  init?(binaryString: String) {
    guard let bit = Int(binaryString) else { return nil }
    self.init(bit: bit)
  }

  /// Whether a throwing operation succeeds.
  ///
  /// Provides an equivalent value to this [`is case`expression](https://forums.swift.org/t/pitch-is-case-expressions/64185):
  /// ```
  /// Result(catching: success) is case .success
  /// ```
  static func success(catching success: @autoclosure () throws -> some Any) -> Self {
    do {
      _ = try success()
      return true
    } catch {
      return false
    }
  }

  /// Modify a value if `true`.
  /// - Returns: An unmodified value, when false.
  @inlinable func reduce<Result>(
    _ resultWhenFalse: Result,
    _ makeResult: (_ resultWhenFalse: Result) throws -> Result
  ) rethrows -> Result {
    self ? try makeResult(resultWhenFalse) : resultWhenFalse
  }

  /// "Not `self`"
  var toggled: Self {
    self…{ $0.toggle() }
  }
}

// MARK: - Comparable
public extension Bool {
  /// A way to compare `Bool`s.
  ///
  /// Note: `false` is "less than" `true`.
  enum Comparable: CaseIterable, Swift.Comparable {
    case `false`, `true`
  }

  /// Make a `Bool` `Comparable`, with `false` being "less than" `true`.
  var comparable: Comparable { .init(booleanLiteral: self) }
}

extension Bool.Comparable: ExpressibleByBooleanLiteral {
  public init(booleanLiteral value: Bool) {
    self = value ? .true : .false
  }
}

// MARK: - Bool-returning closures

public prefix func !<Root>(
  getBool: @escaping (Root) -> Bool
) -> (Root) -> Bool {
  getBool…(!)
}

public prefix func !(
  getBool: @escaping () -> Bool
) -> () -> Bool {
  getBool…((!) as (Bool) -> _)
}

public extension Sequence<() -> Bool> {
  ///- Returns: whether all elements of the sequence evaluate to `bool`
  func containsOnly(_ bool: Bool) -> Bool {
    allSatisfy { getBool in bool == getBool() }
  }
}
