import Algorithms

public extension Optional {
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
  /// - Throws: `Any?.Nil` when `nil`,
  ///   or  `Any??.Nil` when wrapping another `Optional` that is `nil`.
  var doublyUnwrapped: Wrapped {
    get throws {
      switch self {
      case let doubleWrapped?? as Self?:
        return doubleWrapped
      case _?:
        throw Self?.nil
      case nil:
        throw Self.nil
      }
    }
  }
}
