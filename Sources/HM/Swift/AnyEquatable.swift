/// A type-erased equatable value.
///
/// An `Equatable` instance is stored as a "`Cast`".
/// Only instances that can be cast to that type can be `==`'d with the `AnyEquatable`.
public struct AnyEquatable<Cast> {
  public init(_ equatable: some Equatable) throws(CastError) {
    equals = try equatable.getEquals()
    cast = equatable as! Cast
  }

  private let equals: (Cast) -> Bool
  private let cast: Cast
}

extension AnyEquatable: Equatable {
  public static func == (equatable0: Self, equatable1: Self) -> Bool {
    equatable0 == equatable1.cast
  }
}

public extension AnyEquatable {
  static func == (equatable: Self, cast: Cast) -> Bool {
    equatable.equals(cast)
  }

  static func == (cast: Cast, equatable: Self) -> Bool {
    equatable.equals(cast)
  }
}
