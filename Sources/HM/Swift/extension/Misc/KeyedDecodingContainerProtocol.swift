public extension KeyedDecodingContainerProtocol {
  func decode<Decodable: Swift.Decodable>(forKey key: Key) throws -> Decodable {
    try decode(Decodable.self, forKey: key)
  }
}
