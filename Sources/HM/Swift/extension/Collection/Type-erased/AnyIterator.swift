public extension AnyIterator {
  /// A single-pass version of a sequence,
  /// whose iteration can be "paused", if not fully-consumed in one operation.
  init<Sequence: Swift.Sequence>(pauseable sequence: Sequence)
  where Sequence.Element == Element {
    self.init( sequence.makeIterator() )
  }

  /// Use when `AnyIterator` is required / `UnfoldSequence` can't be used.
  init<State>(
    state: State,
    _ getNext: @escaping (inout State) -> Element?
  ) {
    var state = state
    self.init { getNext(&state) }
  }
}
