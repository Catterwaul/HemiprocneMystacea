import MapKit

public extension MKCoordinateRegion {
  enum CodingKey: Swift.CodingKey {
    case center
    case span
  }
}

extension MKCoordinateRegion: Decodable {
  public init(from decoder: Decoder) throws {
    try self.init(
      Self.init, (CodingKey.center, .span),
      decoder: decoder
    )
  }
}

extension MKCoordinateRegion: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKey.self)
    try container.encode(center, forKey: .center)
    try container.encode(span, forKey: .span)
  }
}

extension MKCoordinateRegion: Equatable {
  public static func == (region0: Self, region1: Self) -> Bool {
    let getProperties = Tuple(\Self.center, \.span)
    return getProperties(region1) == getProperties(region1)
  }
}
