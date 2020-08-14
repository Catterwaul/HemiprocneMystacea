public extension KeyedDecodingContainerProtocol {
  /// Decode, relying on the return type, to avoid having to explicitly use a metatype argument.
  func decode<Decodable: Swift.Decodable>(forKey key: Key) throws -> Decodable {
    try decode(Decodable.self, forKey: key)
  }
}
