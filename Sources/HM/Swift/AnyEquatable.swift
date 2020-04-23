public struct AnyEquatable<Cast> {
  public init<Equatable: Swift.Equatable>(_ equatable: Equatable) throws {
    equals = try equatable.getEquals()
    cast = equatable as! Cast
  }

  private let equals: (Cast) -> Bool
  private let cast: Cast
}

extension AnyEquatable: Swift.Equatable {
  public static func == (equatable0: Self, equatable1: Self) -> Bool {
    equatable0 == equatable1.cast
  }
}

public extension AnyEquatable {
  static func == (equatable: Self, castable: Cast) -> Bool {
    equatable.equals(castable)
  }

  static func == (castable: Cast, equatable: Self) -> Bool {
    equatable.equals(castable)
  }
}
