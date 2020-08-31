public extension Optional {
  /// Wraps a value in an optional, based on a condition.
  /// - Parameters:
  ///   - wrapped: A non-optional value.
  ///   - getIsNil: The condition that will result in `nil`.
  init(
    _ wrapped: Wrapped,
    nilWhen getIsNil: (Wrapped) throws -> Bool
  ) rethrows {
    self = try getIsNil(wrapped) ? nil : wrapped
  }

  /// Exchange two optionals for a single optional tuple.
  /// - Returns: `nil` if either tuple element is `nil`.
  init<Wrapped0, Wrapped1>( optionals: (Wrapped0?, Wrapped1?) )
  where Wrapped == (Wrapped0, Wrapped1) {
    switch optionals {
    case let (wrapped0?, wrapped1?):
      self = (wrapped0, wrapped1)
    default:
      self = nil
    }
  }

  /// - Parameters:
  ///   - makeResult: arguments: (`resultWhenNil`, `self!`)
  func reduce<Result>(
    _ resultWhenNil: Result,
    _ makeResult: (_ resultWhenNil: Result, _ self: Wrapped) throws -> Result
  ) rethrows -> Result {
    try map { try makeResult(resultWhenNil, $0) }
    ?? resultWhenNil
  }

  struct UnwrapError: Error { }

  /// Throw an error if `nil`.
  /// - Throws: `UnwrapError`
  /// - Note: Useful for emulating `break`, with `map`, `forEach`, etc.
  func unwrap() throws -> Wrapped {
    try self ?? { throw UnwrapError() } ()
  }
}
