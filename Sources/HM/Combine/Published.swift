import struct Combine.Published

extension Published: Encodable where Value: Encodable {
  public func encode(to encoder: Encoder) throws {
    guard
      let storageValue =
        Mirror(reflecting: self).descendant("storage")
        .map(Mirror.init)?.children.first?.value,
      let value =
        storageValue as? Value
        ?? ((storageValue as? Publisher).map { publisher in
          Mirror(reflecting: publisher).descendant("subject", "currentValue")
        }) as? Value
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
