/// An iterator that stores its most recent iteration.
public struct CurrentValueIterator<Iterator: IteratorProtocol> {
  public typealias Element = Iterator.Element

  public private(set) var value: Element?
  private var iterator: Iterator
}

// MARK: - public
public extension CurrentValueIterator {
  init<Sequence: Swift.Sequence>(_ sequence: Sequence)
  where Sequence.Iterator == Iterator {
    iterator = sequence.makeIterator()
    value = iterator.next()
  }
}

// MARK: - IteratorProtocol
extension CurrentValueIterator: IteratorProtocol {
  @discardableResult public mutating func next() -> Element? {
    value = iterator.next()
    return value
  }
}

extension CurrentValueIterator: Sequence { }
