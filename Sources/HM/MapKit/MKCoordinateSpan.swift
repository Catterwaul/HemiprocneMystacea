import struct MapKit.MKCoordinateSpan

public extension MKCoordinateSpan {
  enum CodingKey: Swift.CodingKey {
    case latitudeDelta
    case longitudeDelta
  }
}

extension MKCoordinateSpan: Decodable {
  public init(from decoder: Decoder) throws {
    try self.init(
      Self.init, (CodingKey.latitudeDelta, .longitudeDelta),
      decoder: decoder
    )
  }
}

extension MKCoordinateSpan: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKey.self)
    try container.encode(latitudeDelta, forKey: .latitudeDelta)
    try container.encode(longitudeDelta, forKey: .longitudeDelta)
  }
}

extension MKCoordinateSpan: Equatable {
  public static func == (span0: Self, span1: Self) -> Bool {
    let getProperties = Tuple(\Self.latitudeDelta, \.longitudeDelta)
    return getProperties(span0) == getProperties(span1)
  }
}
