public extension EnumeratedSequence {
  struct Error: Swift.Error {
    public let index: Int
    public let error: Swift.Error
  }

  /// - Throws: EnumeratedSequence.Error
  func mapElements<Transformed>(
    _ transform: (Base.Element) throws -> Transformed
  ) throws -> [Transformed] {
    try map { enumeratedElement throws(Error) in
      do { return try transform(enumeratedElement.element) }
      catch { throw Error(index: enumeratedElement.offset, error: error) }
    }
  }
}
