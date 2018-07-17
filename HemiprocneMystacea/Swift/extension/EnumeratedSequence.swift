public extension EnumeratedSequence {
  /// - Throws: EnumeratedSequenceError
  func mapElements<Transformed>(
    _ transform: (Base.Element) throws -> Transformed
  ) throws -> [Transformed] {
    return try self.map {
      do { return try transform($0.element) }
      catch {
        throw EnumeratedSequenceError(
          index: $0.offset,
          error: error
        )
      }
    }
  }
}

public struct EnumeratedSequenceError: Error {
  public let index: Int
  public let error: Error
}
