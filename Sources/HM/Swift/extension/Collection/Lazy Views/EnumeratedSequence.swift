public extension EnumeratedSequence {
  struct Error: Swift.Error {
    public let index: Int
    public let error: Swift.Error
  }

  /// - Throws: EnumeratedSequenceError
  func mapElements<Transformed>(
    _ transform: (Base.Element) throws -> Transformed
  ) throws -> [Transformed] {
    try self.map {
      do { return try transform($0.element) }
      catch { throw Error(index: $0.offset, error: error) }
    }
  }
}
