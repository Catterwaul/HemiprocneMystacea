public extension AnySequence {
  /// Backtrack to the previous `next`, before resuming iteration.
  static func makeIterator<Sequence: Swift.Sequence>(_ sequence: Sequence)
  -> (Self, getPrevious: () -> Element?)
  where Sequence.Element == Element {
    var previous: Element?
    
    let iterator = AnyIterator(sequence) {
      if $0 != nil {
        previous = $0
      }
    }

    return (
      previous.map { CollectionOfOne($0) + iterator }
        ?? .init(iterator),
      { previous }
    )
  }

  /// Use when `AnySequence` is required / `AnyIterator` can't be used.
  /// - Parameter getNext: Executed as the `next` method of this sequence's iterator.
  init(_ getNext: @escaping () -> Element?) {
    self.init( Iterator(getNext) )
  }

  init<Sequence: Swift.Sequence>(cycling sequence: Sequence)
  where Sequence.Element == Element {
    self.init { [makeIterator = sequence.makeIterator] in
      Iterator( state: makeIterator() ) { iterator in
        if let next = iterator.next() {
          return next
        }
        else {
          iterator = makeIterator()
          return iterator.next()
        }
      }
    }
  }
}
