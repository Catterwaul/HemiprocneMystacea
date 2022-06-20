public extension Array {
  /// Iterate through an `UnkeyedDecodingContainer` and create an `Array`.
  /// - Parameters:
  ///   - iterate: Mutates `container` and returns an `Element`, or `throw`s.
  init(
    container: some UnkeyedDecodingContainer,
    iterate: (inout UnkeyedDecodingContainer) throws -> Element
  ) throws {
    try self.init(
      initialState: container,
      while: { !$0.isAtEnd },
      iterate: iterate
    )
  }
}

