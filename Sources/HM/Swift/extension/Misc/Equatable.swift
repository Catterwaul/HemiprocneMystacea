public extension Equatable {
  /// Equate two values of unknown type.
  static func equate(_ any0: Any, _ any1: Any) -> Bool {
    guard
      let equatable0 = any0 as? Self,
      let equatable1 = any1 as? Self
    else { return false }

    return equatable0 == equatable1
  }

  /// A closure that equates another instance to this intance.
  /// - Parameters:
  ///   - _: Use the metatype for `Castable` to avoid explicit typing.
  /// - Throws: `CastError.Impossible` if a `Castable` can't be cast to `Self`.
  func getEquals<Castable>(_: Castable.Type = Castable.self) throws -> (Castable) -> Bool {
    if let error = CastError(self, desired: Castable.self)
    { throw error }

    return { self == $0 as? Self }
  }
}
