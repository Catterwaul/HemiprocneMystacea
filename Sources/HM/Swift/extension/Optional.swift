infix operator =?: AssignmentPrecedence
import Algorithms

public extension Optional {
  /// Represents that an `Optional` was `nil`.
  enum UnwrapError: Error {
    case `nil`
    case typeMismatch
  }

  /// Assign only non-nil values.
  static func =? (optional0: inout Self, optional1: Self) {
    if let optional1 {
      optional0 = optional1
    }
  }

  /// Assign only non-nil values.
  static func =? (wrapped: inout Wrapped, optional: Self) {
    if let optional {
      wrapped = optional
    }
  }

  /// Exchange two optionals for a single optional tuple.
  /// - Returns: `nil` if either tuple element is `nil`.
  init<Wrapped0, Wrapped1>(_ optional0: Wrapped0?, _ optional1: Wrapped1?)
  where Wrapped == (Wrapped0, Wrapped1) {
    self = .init((optional0, optional1))
  }

  /// Exchange two optionals for a single optional tuple.
  /// - Returns: `nil` if either tuple element is `nil`.
  init<Wrapped0, Wrapped1>(_ optionals: (Wrapped0?, Wrapped1?))
  where Wrapped == (Wrapped0, Wrapped1) {
    switch optionals {
    case let (wrapped0?, wrapped1?):
      self = (wrapped0, wrapped1)
    default:
      self = nil
    }
  }

  /// Exchange three optionals for a single optional tuple.
  /// - Returns: `nil` if any tuple element is `nil`.
  init<Wrapped0, Wrapped1, Wrapped2>(_ optionals: (Wrapped0?, Wrapped1?, Wrapped2?))
  where Wrapped == (Wrapped0, Wrapped1, Wrapped2) {
    switch optionals {
    case let (wrapped0?, wrapped1?, wrapped2?):
      self = (wrapped0, wrapped1, wrapped2)
    default:
      self = nil
    }
  }

  /// Exchange four optionals for a single optional tuple.
  /// - Returns: `nil` if any tuple element is `nil`.
  init<Wrapped0, Wrapped1, Wrapped2, Wrapped3>(_ optionals: (Wrapped0?, Wrapped1?, Wrapped2?, Wrapped3?))
  where Wrapped == (Wrapped0, Wrapped1, Wrapped2, Wrapped3) {
    switch optionals {
    case let (wrapped0?, wrapped1?, wrapped2?, wrapped3?):
      self = (wrapped0, wrapped1, wrapped2, wrapped3)
    default:
      self = nil
    }
  }

  /// [An alternative to overloading `??` to throw errors upon `nil`.](
  /// https://forums.swift.org/t/unwrap-or-throw-make-the-safe-choice-easier/14453/7)
  /// - Note: Useful for emulating `break`, with `map`, `forEach`, etc.
  /// - Throws: `UnwrapError` when `nil`.
  var unwrapped: Wrapped {
    get throws {
      switch self {
      case let wrapped?: return wrapped
      case nil: throw UnwrapError.nil
      }
    }
  }

  /// [An alternative to overloading `??` to throw errors upon `nil`.](
  /// https://forums.swift.org/t/unwrap-or-throw-make-the-safe-choice-easier/14453/7)
  /// - Note: Useful for emulating `break`, with `map`, `forEach`, etc.
  /// - Throws: `UnwrapError`
  func unwrap<Wrapped>() throws -> Wrapped {
    guard case let wrapped as Wrapped = try unwrapped
    else { throw UnwrapError.typeMismatch }

    return wrapped
  }

  /// Create a single-element array literal, or an empty one.
  /// - Returns: `[self!]` if `.some`; `[]` if `nil`.
  /// - Note: This cannot be generalized to all types,
  /// as Swift doesn't employ  universal non-optional defaults.
  func compacted<ExpressibleByArrayLiteral: Swift.ExpressibleByArrayLiteral>() -> ExpressibleByArrayLiteral
  where ExpressibleByArrayLiteral.ArrayLiteralElement == Wrapped {
    .init(compacting: self)
  }

  /// Transform `.some` into `.none`, if a condition fails.
  /// - Parameters:
  ///   - isSome: The condition that will result in `nil`, when evaluated to `false`.
  func filter(_ isSome: (Wrapped) throws -> Bool) rethrows -> Self {
    try flatMap { try isSome($0) ? $0 : nil }
  }

  /// Modify a wrapped value if not `nil`.
  /// - Parameters:
  ///   - makeResult: arguments: (`resultWhenNil`, `self!`)
  /// - Returns: An unmodified value, when `nil`.
  func reduce<Result>(
    _ resultWhenNil: Result,
    _ makeResult: (_ resultWhenNil: Result, _ self: Wrapped) throws -> Result
  ) rethrows -> Result {
    try map { try makeResult(resultWhenNil, $0) }
    ?? resultWhenNil
  }
}

// MARK: - Sequence

extension Sequence {
  /// A compacted version of this sequence, only when no elements are `nil`.
  func compactedIfAllAreSome<Wrapped>() -> (CompactedSequence<Self, Wrapped>)?
  where Element == Wrapped? {
    guard (allSatisfy { $0 != nil }) else { return nil }

    return compacted()
  }
}
