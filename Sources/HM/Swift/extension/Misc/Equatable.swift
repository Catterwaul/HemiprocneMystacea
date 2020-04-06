public extension Equatable {
  /// Equate two values of unknown type.
  static func equate(_ any0: Any, _ any1: Any) -> Bool {
    guard
      let equatable0 = any0 as? Self,
      let equatable1 = any1 as? Self
    else { return false }

    return equatable0 == equatable1
  }
}
