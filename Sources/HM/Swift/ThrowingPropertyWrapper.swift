/// A type that represents a `get throws` accessor.
public protocol ThrowingPropertyWrapper<WrappedValue> {
  associatedtype WrappedValue
  var wrappedValue: WrappedValue { get throws }
}

extension Optional: ThrowingPropertyWrapper {
  /// - Throws: `UnwrapError`
  public var wrappedValue: Wrapped {
    @inlinable get throws {
      switch self {
      case let wrapped?: return wrapped
      case nil: throw UnwrapError()
      }
    }
  }
}

extension Result: ThrowingPropertyWrapper {
  /// - Throws: `Failure`
  public var wrappedValue: Success {
    @inlinable get throws { try get() }
  }
}

// MARK: - public
infix operator =?: AssignmentPrecedence

public extension ThrowingPropertyWrapper {
  /// Assign only non-throwing values.
  static func =? (self0: inout Self, self1: Self) {
    if .success(catching: try self1.wrappedValue) {
      self0 = self1
    }
  }

  /// Assign only non-throwing values.
  static func =? (wrappedValue: inout WrappedValue, self: Self) {
    try? wrappedValue = self.wrappedValue
  }

  /// Create a single-element array literal, or an empty one.
  /// - Returns: `[wrappedValue]` or `[]`
  /// - Note: This cannot be generalized to all types,
  /// as Swift doesn't employ  universal non-optional defaults.
  func compacted<ExpressibleByArrayLiteral: Swift.ExpressibleByArrayLiteral>() -> ExpressibleByArrayLiteral
  where ExpressibleByArrayLiteral.ArrayLiteralElement == WrappedValue {
    .init(compacting: self)
  }

  /// Modify a wrapped value if not `nil`.
  /// - Parameters:
  ///   - makeResult: arguments: (`resultWhenNil`, `self!`)
  /// - Returns: An unmodified value, when `nil`.
  func reduce<Result>(
    _ resultWhenNil: Result,
    _ makeResult: (_ resultWhenNil: Result, _ wrappedValue: WrappedValue) throws -> Result
  ) rethrows -> Result {
    let wrappedValue: WrappedValue
    do {
      wrappedValue = try self.wrappedValue
    } catch {
      return resultWhenNil
    }
    return try makeResult(resultWhenNil, wrappedValue)
  }
}

postfix operator …?
public extension ThrowingPropertyWrapper where WrappedValue: Sequence {
  /// `wrappedValue`, or an empty sequence if it throws.
  ///
  ///  Useful for `for` loops.
  ///
  ///   ```swift
  ///       for element in optional…? {
  ///   ```
  @available(
    swift, deprecated: 6,
    message: "`-> some Sequence<WrappedValue.Element>` causes test to fail."
  )
  static postfix func …?(_ self: Self) -> UnfoldSequence<WrappedValue.Element, WrappedValue.Iterator?> {
    sequence(state: (try? self.wrappedValue)?.makeIterator()) { $0?.next() }
  }
}
