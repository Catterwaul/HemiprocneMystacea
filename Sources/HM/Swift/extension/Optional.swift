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

  /// - Parameters:
  ///   - makeResult: arguments: (`resultWhenNil`, `self!`)
  func reduce<Result>(
    _ resultWhenNil: Result,
    _ makeResult: (_ resultWhenNil: Result, _ self: Wrapped) throws -> Result
  ) rethrows -> Result {
    try self.map { try makeResult(resultWhenNil, $0) }
    ?? resultWhenNil
  }
}
