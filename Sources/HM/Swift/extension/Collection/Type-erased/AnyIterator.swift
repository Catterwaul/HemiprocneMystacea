public extension AnyIterator {
  /// Use when `AnyIterator` is required / `UnfoldSequence` can't be used.
  init<State>(
    state: State,
    _ getNext: @escaping (inout State) -> Element?
  ) {
    var state = state
    self.init { getNext(&state) }
  }
}
