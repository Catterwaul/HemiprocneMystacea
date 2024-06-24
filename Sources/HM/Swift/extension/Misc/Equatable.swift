public extension Equatable {
  /// Equate two values using a closure.
  static func equate<Wrapped>(
    _ optional0: Wrapped?, to optional1: Wrapped?,
    using transform: (Wrapped) throws -> some Equatable
  ) rethrows -> Bool {
    try optional0.map(transform) == optional1.map(transform)
  }

  /// Equate two values of unknown types.
  static func equate(_ any0: some Any, _ any1: some Any) -> Bool {
    ((any0, any1) as? (Self, Self)).map(==) ?? false
  }

  /// Equate with a value of unknown type.
  func equals(_ any: some Any) -> Bool {
    self == any as? Self
  }

  /// A closure that equates another instance to this intance.
  /// - Parameters:
  ///   - _: Use the metatype for `Castable` to avoid explicit typing.
  /// - Throws: `.impossible` if a `Castable` can't be cast to `Self`.
  func getEquals<Castable>(_: Castable.Type = Castable.self) throws(CastError) -> (Castable) -> Bool {
    if let error = CastError(self, desired: Castable.self) { throw error }
    return { self == $0 as? Self }
  }
}

// MARK: - AnyObject
public extension Equatable where Self: AnyObject {
  static func == (class0: Self, class1: Self) -> Bool {
    class0 === class1
  }
}
