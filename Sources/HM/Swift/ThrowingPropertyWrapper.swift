/// A type that represents a `get throws` accessor.
public protocol ThrowingPropertyWrapper<Value, Error> {
  associatedtype Value
  associatedtype Error: Swift.Error

  var wrappedValue: Value { get throws }
}

extension Optional: ThrowingPropertyWrapper {
  public typealias Error = UnwrapError

  /// Represents that an `Optional` was `nil`.
  public struct UnwrapError: Swift.Error & Equatable {
    public init() { }
  }

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
  public typealias Error = Failure

  /// - Throws: `Failure`
  public var wrappedValue: Success {
    @inlinable get throws { try get() }
  }

  public mutating func setWrappedValue(_ newValue: Value) {
    self = .success(newValue)
  }
}

// MARK: - public

public extension ThrowingPropertyWrapper {
  /// Create a single-element array literal, or an empty one.
  /// - Returns: `[wrappedValue]` or `[]`
  /// - Note: This cannot be generalized to all types,
  /// as Swift doesn't employ  universal non-optional defaults.
  func compacted<ExpressibleByArrayLiteral: Swift.ExpressibleByArrayLiteral>() -> ExpressibleByArrayLiteral
  where ExpressibleByArrayLiteral.ArrayLiteralElement == Value {
    .init(compacting: self)
  }

  /// Modify a wrapped value if not `nil`.
  /// - Parameters:
  ///   - makeResult: arguments: (`resultWhenNil`, `self!`)
  /// - Returns: An unmodified value, when `nil`.
  func reduce<Result>(
    _ resultWhenNil: Result,
    _ makeResult: (_ resultWhenNil: Result, _ wrappedValue: Value) throws -> Result
  ) rethrows -> Result {
    let wrappedValue: Value
    do {
      wrappedValue = try self.wrappedValue
    } catch {
      return resultWhenNil
    }
    return try makeResult(resultWhenNil, wrappedValue)
  }
}

postfix operator …?
public extension ThrowingPropertyWrapper where Value: Sequence {
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
  static postfix func …?(_ self: Self) -> UnfoldSequence<Value.Element, Value.Iterator?> {
    sequence(state: (try? self.wrappedValue)?.makeIterator()) { $0?.next() }
  }
}
