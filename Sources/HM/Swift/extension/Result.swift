public extension Result {
  /// `success` for `Optional.some`s; `failure` for `.none`s.
  init(
    success: Success?,
    failure getFailure: @autoclosure () -> Failure
  ) {
    self =
      success.map(Self.success)
      ?? .failure( getFailure() )
  }
}
