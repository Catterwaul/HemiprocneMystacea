public extension AnySequence {
    /// An error thrown from a call to `onlyMatch`.
  enum OnlyMatchError: Swift.Error {
    case noMatches
    case moreThanOneMatch
  }

  enum Spliteration {
    case separator(Element)
    case subSequence([Element])
  }

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
    self.init(Iterator(getNext))
  }

  /// A cyclical version of a sequence.
  init<Sequence: Swift.Sequence>(cycling sequence: Sequence)
  where Sequence.Element == Element {
    self.init { [makeIterator = sequence.makeIterator] in
      Swift.sequence(state: makeIterator()) { iterator in
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

  /// Like `zip`, but with `nil` elements for the shorter sequence after it is exhausted.
  init<Sequence0: Sequence, Sequence1: Sequence>(
    zip zipped: (Sequence0, Sequence1)
  ) where Element == (Sequence0.Element?, Sequence1.Element?) {
    self.init(
      sequence(
        state: (zipped.0.makeIterator(), zipped.1.makeIterator())
      ) { iterators in
        Optional(
          (iterators.0.next(), iterators.1.next())
        )
        .filter { $0 != nil || $1 != nil }
      }
    )
  }
}

@inlinable public func zip<
  Sequence0: Sequence,
  Sequence1: Sequence,
  Sequence2: Sequence
>(
  _ sequence0: Sequence0,
  _ sequence1: Sequence1,
  _ sequence2: Sequence2
) -> AnySequence<(
  Sequence0.Element,
  Sequence1.Element,
  Sequence2.Element
)> {
  .init(
    sequence(
      state: (
        sequence0.makeIterator(),
        sequence1.makeIterator(),
        sequence2.makeIterator()
      )
    ) {
      .init(
        ( $0.0.next(),
          $0.1.next(),
          $0.2.next()
        )
      )
    }
  )
}

@inlinable public func zip<
  Sequence0: Sequence,
  Sequence1: Sequence,
  Sequence2: Sequence,
  Sequence3: Sequence
>(
  _ sequence0: Sequence0,
  _ sequence1: Sequence1,
  _ sequence2: Sequence2,
  _ sequence3: Sequence3
) -> AnySequence<(
  Sequence0.Element,
  Sequence1.Element,
  Sequence2.Element,
  Sequence3.Element
)> {
  .init(
    sequence(
      state: (
        sequence0.makeIterator(),
        sequence1.makeIterator(),
        sequence2.makeIterator(),
        sequence3.makeIterator()
      )
    ) {
      .init(
        ( $0.0.next(),
          $0.1.next(),
          $0.2.next(),
          $0.3.next()
        )
      )
    }
  )
}
