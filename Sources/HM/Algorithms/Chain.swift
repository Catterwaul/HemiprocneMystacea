import Algorithms

@inlinable public func chainWithoutOverlap<Element: Equatable>(
  _ sequence1: some Sequence<Element>, _ sequence2: some Sequence<Element>
) -> some Sequence<Element> {
  chain(
    sequence1.withDropIterators.lazy
      .prefix { !sequence2.starts(with: IteratorSequence($1)) }
      .map(\.0),
    sequence2
  )
}
