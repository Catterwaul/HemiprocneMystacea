public extension AnySequence {
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
