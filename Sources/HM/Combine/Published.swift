import struct Combine.Published

extension Published: Encodable where Value: Encodable {
  public func encode(to encoder: Encoder) throws {
    guard let value = Mirror.peel(self) as Encodable?
    else { throw EncodingError.invalidValue(self, codingPath: encoder.codingPath) }

    try value.encode(to: encoder)
  }
}

extension Published: Decodable where Value: Decodable {
  public init(from decoder: Decoder) throws {
    self.init(
      initialValue: try .init(from: decoder)
    )
  }
}
