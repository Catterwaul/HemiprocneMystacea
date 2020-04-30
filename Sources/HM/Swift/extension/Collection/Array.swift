public extension Array {
  //MARK:- Initializers

  /// Create an `Array` if `subject's` values are all of one type.
  /// - Note: Useful for converting tuples to `Array`s.
  init?<Subject>(mirrorChildValuesOf subject: Subject) {
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
      Never.ending.lazy
      .prefix { continuing(state) }
      .map { try iterate(&state) }
  }

  //MARK:- Properties

  /// The first array will be shorter by one element,
  /// if `count` is odd.
  var splitInHalf: [Array] {
    let halfCount = count / 2
    return [
      prefix(upTo: halfCount),
      dropFirst(halfCount)
    ].map(Array.init)
  }
}
