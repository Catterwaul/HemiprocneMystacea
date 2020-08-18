import struct CoreLocation.CLLocationCoordinate2D

public extension CLLocationCoordinate2D {
  enum CodingKey: Swift.CodingKey {
    case latitude
    case longitude
  }
}

extension CLLocationCoordinate2D: Decodable {
  public init(from decoder: Decoder) throws {
    try self.init(
      Self.init, (CodingKey.latitude, .longitude),
      decoder: decoder
    )
  }
}

extension CLLocationCoordinate2D: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKey.self)
    try container.encode(latitude, forKey: .latitude)
    try container.encode(longitude, forKey: .longitude)
  }
}

extension CLLocationCoordinate2D: Equatable {
  public static func == (coordinate0: Self, coordinate1: Self) -> Bool {
    let getProperties = Tuple(\Self.latitude, \.longitude)
    return getProperties(coordinate0) == getProperties(coordinate1)
  }
}