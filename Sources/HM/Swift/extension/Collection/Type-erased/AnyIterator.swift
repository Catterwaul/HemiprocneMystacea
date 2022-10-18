public extension AnyIterator {
  /// Use when `AnyIterator` is required / `UnfoldSequence` can't be used.
  init<State>(
    state: State,
    _ getNext: @escaping (inout State) -> Element?
  ) {
    var state = state
    self.init { getNext(&state) }
  }

  /// Process iterations with a closure.
  /// - Parameters:
  ///   - processNext: Executes with every iteration.
  init(
    _ sequence: some Sequence<Element>,
    processNext: @escaping (Element?) -> Void
  ) {
    self.init(state: sequence.makeIterator()) { iterator -> Element? in
      let next = iterator.next()
      processNext(next)
      return next
    }
  }
}
