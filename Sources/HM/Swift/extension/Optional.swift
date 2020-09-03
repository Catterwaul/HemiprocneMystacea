public extension Optional {
  /// Transform `.some` into `.none`, if a condition fails.
  /// - Parameters:
  ///   - isSome: The condition that will result in `nil`, when evaluated to `false`.
  func filter(_ isSome: (Wrapped) throws -> Bool) rethrows -> Self {
    try flatMap { try isSome($0) ? $0 : nil }
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

  struct UnwrapError: Error { }

  /// Throw an error if `nil`.
  /// - Throws: `UnwrapError`
  /// - Note: Useful for emulating `break`, with `map`, `forEach`, etc.
  func unwrap() throws -> Wrapped {
    try self ?? { throw UnwrapError() } ()
  }
}
