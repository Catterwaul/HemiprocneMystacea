import Algorithms

@inlinable public func chainWithoutOverlap<Sequence1: Sequence, Sequence2: Sequence>(
  _ sequence1: Sequence1, _ sequence2: Sequence2
) -> Chain2Sequence<
  LazyMapSequence<
    LazyPrefixWhileSequence<
      UnfoldSequence<(Sequence1.Element, Sequence1.Iterator), Sequence1.Iterator>
    >,
    Sequence1.Element
  >,
  Sequence2
> where Sequence1.Element: Equatable, Sequence1.Element == Sequence2.Element {
  chain(
    sequence1.withDropIterators.lazy
      .prefix { !sequence2.starts(with: IteratorSequence($1)) }
      .map(\.0),
    sequence2
  )
}
