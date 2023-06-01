public extension Array {
  // MARK: - Initializers

  /// Create an `Array` if `subject's` values are all of one type.
  /// - Note: Useful for converting tuples to `Array`s.
  init?(mirrorChildValuesOf subject: some Any) {
    guard let array =
      Mirror(reflecting: subject).children.map(\.value)
      as? Self
    else { return nil }

    self = array
  }

  /// A hack to deal with `Sequence.next` not being allowed to `throw`.
  /// - Parameters:
  ///   - initialState: Mutable state.
  ///   - continuing: Check the state to see if iteration is complete.
  ///   - iterate: Mutates the state and returns an `Element`, or `throw`s.
  init<State>(
    initialState: State,
    while continuing: @escaping (State) -> Bool,
    iterate: (inout State) throws -> Element
  ) throws {
    var state = initialState
    self = try
      `while` { continuing(state) }
      .map { try iterate(&state) }
  }
}

// MARK: - Equatable
public extension Array where Element: Equatable {
  ///- Returns: `nil` if not prefixed with `prefix`.
  func without(prefix: some Sequence<Element>) -> Self? {
    without(adfix: prefix, hasAdfix: starts, drop: dropFirst)
      .map(Self.init)
  }
}

// MARK: - ExpressibleByArrayLiteral
public extension ExpressibleByArrayLiteral {
  /// Create a single-element array literal, or an empty one.
  /// - Returns: `[optional!]` if `.some`; `[]` if `nil`.
  /// - Note: This cannot be generalized to all types,
  /// as Swift doesn't employ  universal non-optional defaults.
  init(compacting wrapper: some ThrowingPropertyWrapper<ArrayLiteralElement>) {
    do {
      self = [try wrapper.wrappedValue]
    } catch {
      self = []
    }
  }
}
