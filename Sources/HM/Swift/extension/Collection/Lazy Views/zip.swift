/// `zip` a sequence with a single value, instead of another sequence.
@inlinable public func zip<Sequence: Swift.Sequence, Constant>(
  _ sequence: Sequence, _ constant: Constant
) -> some Swift.Sequence<(Sequence.Element, Constant)> {
  zip(sequence, HM.sequence(constant))
}

@inlinable public func zip<
  Sequence0: Sequence,
  Sequence1: Sequence,
  Sequence2: Sequence
>(
  _ sequence0: Sequence0,
  _ sequence1: Sequence1,
  _ sequence2: Sequence2
) -> some Sequence<(
  Sequence0.Element,
  Sequence1.Element,
  Sequence2.Element
)> {
  sequence(
    state: (
      sequence0.makeIterator(),
      sequence1.makeIterator(),
      sequence2.makeIterator()
    )
  ) {
    .zip(
      ( $0.0.next(),
        $0.1.next(),
        $0.2.next()
      )
    )
  }
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
) -> some Sequence<(
  Sequence0.Element,
  Sequence1.Element,
  Sequence2.Element,
  Sequence3.Element
)> {
  sequence(
    state: (
      sequence0.makeIterator(),
      sequence1.makeIterator(),
      sequence2.makeIterator(),
      sequence3.makeIterator()
    )
  ) {
    .zip(
      ( $0.0.next(),
        $0.1.next(),
        $0.2.next(),
        $0.3.next()
      )
    )
  }
}
