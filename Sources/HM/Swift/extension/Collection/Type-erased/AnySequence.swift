import Algorithms

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
  static func makeIterator(_ sequence: some Sequence<Element>)
  -> (some Sequence<Element>, getPrevious: () -> Element?) {
    var previous: Element?
    
    let iterator = AnyIterator(sequence) {
      if $0 != nil {
        previous = $0
      }
    }

    return (
      previous.map { Self(chain(CollectionOfOne($0), iterator)) }
        ?? .init(iterator),
      { previous }
    )
  }

  /// Use when `AnySequence` is required / `AnyIterator` can't be used.
  /// - Parameter getNext: Executed as the `next` method of this sequence's iterator.
  init(_ getNext: @escaping () -> Element?) {
    self.init(Iterator(getNext))
  }

  /// Like `zip`, but with `nil` elements for the shorter sequence after it is exhausted.
  static func zip<Sequence0: Sequence, Sequence1: Sequence>(
    _ zipped0: Sequence0, _ zipped1: Sequence1
  ) -> some Sequence<(Sequence0.Element?, Sequence1.Element?)>
  where Element == (Sequence0.Element?, Sequence1.Element?) {
    zipForever(zipped0, zipped1).prefix { !($0 == nil && $1 == nil) }
  }
}
