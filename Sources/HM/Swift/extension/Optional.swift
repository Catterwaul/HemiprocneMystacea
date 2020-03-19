public extension Optional {
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
