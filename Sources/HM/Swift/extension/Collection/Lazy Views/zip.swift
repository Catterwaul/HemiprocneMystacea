/// `zip` a sequence with a single value, instead of another sequence.
@inlinable public func zip<Sequence: Swift.Sequence, Constant>(
  _ sequence: Sequence, _ constant: Constant
) -> LazyMapSequence<
  LazySequence<Sequence>.Elements,
  (LazySequence<Sequence>.Element, Constant)
> {
 sequence.lazy.map { ($0, constant) }
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
