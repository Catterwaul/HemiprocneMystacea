import typealias Combine.Published

public extension Published {
  /// The stored value of a `Published`.
  /// - Note: Only useful when not having access to the enclosing class instance.
  var value: Value { Storage(self).value }

  private final class Storage {
    @Published private(set) var value: Value

    init(_ published: Published) {
      _value = published
    }
  }
}

extension Published: @retroactive Encodable where Value: Encodable {
  public func encode(to encoder: Encoder) throws {
    try value.encode(to: encoder)
  }
}

extension Published: @retroactive Decodable where Value: Decodable {
  public init(from decoder: Decoder) throws {
    self.init(initialValue: try .init(from: decoder))
  }
}
