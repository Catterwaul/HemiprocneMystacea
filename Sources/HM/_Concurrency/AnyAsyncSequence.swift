public struct AnyAsyncSequence<Iterator: IteratorProtocol> {
  public init<Sequence: Swift.Sequence>(_ sequence: Sequence)
  where Sequence.Iterator == Iterator {
    makeIterator = sequence.makeIterator
  }
  
  private let makeIterator: () -> Iterator
}

extension AnyAsyncSequence: AsyncSequence {
  public typealias Element = Iterator.Element
  
  public func makeAsyncIterator() -> AnyIterator<Element> {
    .init(makeIterator())
  }
}

extension AnyIterator: AsyncIteratorProtocol { }
