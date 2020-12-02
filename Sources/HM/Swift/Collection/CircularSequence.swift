public struct CircularSequence<Iterator: IteratorProtocol>: Sequence {
  public init<Sequence: Swift.Sequence>(_ sequence: Sequence)
  where Sequence.Iterator == Iterator {
    makeIterator = sequence.makeIterator
    iterator = makeIterator()
  }

  private var iterator: Iterator
  private let makeIterator: () -> Iterator
}

// MARK: IteratorProtocol
extension CircularSequence: IteratorProtocol {
  public mutating func next() -> Iterator.Element? {
    if let next = iterator.next() {
      return next
    }
    else {
      iterator = makeIterator()
      return iterator.next()
    }
  }
}
