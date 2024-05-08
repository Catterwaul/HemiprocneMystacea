import Algorithms

public extension Optional {
  /// Exchange two optionals for a single optional tuple.
  /// - Returns: `nil` if either tuple element is `nil`.
  static func zip<Wrapped0, Wrapped1>(_ optional0: Wrapped0?, _ optional1: Wrapped1?) -> Self
  where Wrapped == (Wrapped0, Wrapped1) {
    .zip((optional0, optional1))
  }

  /// Exchange two optionals for a single optional tuple.
  /// - Returns: `nil` if either tuple element is `nil`.
  static func zip<Wrapped0, Wrapped1>(_ optionals: (Wrapped0?, Wrapped1?)) -> Self
  where Wrapped == (Wrapped0, Wrapped1) {
    switch optionals {
    case let (wrapped0?, wrapped1?): (wrapped0, wrapped1)
    default: nil
    }
  }

  /// Exchange three optionals for a single optional tuple.
  /// - Returns: `nil` if any tuple element is `nil`.
  static func zip<Wrapped0, Wrapped1, Wrapped2>(_ optionals: (Wrapped0?, Wrapped1?, Wrapped2?)) -> Self
  where Wrapped == (Wrapped0, Wrapped1, Wrapped2) {
    switch optionals {
    case let (wrapped0?, wrapped1?, wrapped2?): (wrapped0, wrapped1, wrapped2)
    default: nil
    }
  }

  /// Exchange four optionals for a single optional tuple.
  /// - Returns: `nil` if any tuple element is `nil`.
  static func zip<Wrapped0, Wrapped1, Wrapped2, Wrapped3>(_ optionals: (Wrapped0?, Wrapped1?, Wrapped2?, Wrapped3?)) -> Self
  where Wrapped == (Wrapped0, Wrapped1, Wrapped2, Wrapped3) {
    switch optionals {
    case let (wrapped0?, wrapped1?, wrapped2?, wrapped3?): (wrapped0, wrapped1, wrapped2, wrapped3)
    default: nil
    }
  }

  /// Transform `.some` into `.none`, if a condition fails.
  /// - Parameters:
  ///   - isSome: The condition that will result in `nil`, when evaluated to `false`.
  func filter(_ isSome: (Wrapped) throws -> Bool) rethrows -> Self {
    try flatMap { try isSome($0) ? $0 : nil }
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

// MARK: - Any?
public extension Any? {
  /// Represent an `Optional` with `Any?` instead of `Any`.
  ///
  /// If `any` is an optional, this instance will copy it.
  /// Otherwise, this instance will wrap it.
  ///
  /// - Note: Use this to avoid an `Any?` actually representing an `Any??`.
  init(flattening any: Any) {
    switch any {
    case let optional as Self:
      self = optional
    }
  }

  /// The wrapped value, whether `Wrapped` is an `Optional` or not.
  /// - Throws: `Any?.UnwrapError` when `nil`,
  ///   or  `Any??.UnwrapError` when wrapping another `Optional` that is `nil`.
  var doublyUnwrapped: Wrapped {
    get throws {
      switch self {
      case let doubleWrapped?? as Self?:
        return doubleWrapped
      case _?:
        throw Self?.UnwrapError()
      case nil:
        throw UnwrapError()
      }
    }
  }
}
