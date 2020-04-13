public extension Sequence {
// MARK:- Operators

  /// Equates two `Sequence`s of 2-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable,
    Tuples1: Sequence
  >(tuples0: Self, tuples1: Tuples1) -> Bool
  where Element == (Equatable0, Equatable1), Tuples1.Element == Element {
    tuples0.elementsEqual(tuples1, by: ==)
  }

  /// Equates two `Sequence`s of 3-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable, Equatable2: Equatable,
    Tuples1: Sequence
  >(tuples0: Self, tuples1: Tuples1) -> Bool
  where Element == (Equatable0, Equatable1, Equatable2), Tuples1.Element == Element {
    tuples0.elementsEqual(tuples1, by: ==)
  }

// MARK:- Properties

  /// An empty sequence, whose `Element` "would" match this type's.
  static var empty: AnySequence<Element> {
    .init(EmptyCollection.Iterator.init)
  }

  /// Each elements of the sequence, paired with the element after.
  var consecutivePairs: Zip2Sequence< Self, DropFirstSequence<Self> > {
    zip( self, dropFirst() )
  }

  /// The first element of the sequence.
  /// - Note: `nil` if the sequence is empty.
  var first: Element? {
    var iterator = makeIterator()
    return iterator.next()
  }

// MARK:- Subscripts

  /// Splits a `Sequence` into equal "chunks".
  /// - Parameter maxArrayCount: The maximum number of elements in a chunk.
  /// - Returns: `Array`s with `maxArrayCount` `counts`,
  ///   until the last chunk, which may be smaller.
  subscript(maxArrayCount maxCount: Int) -> AnySequence<[Element]> {
    .init(
      sequence( state: makeIterator() ) { iterator in
        Optional(
          (0..<maxCount).compactMap { _ in iterator.next() },
          nilWhen: \.isEmpty
        )
      }
    )
  }

// MARK:- Methods

  /// The number of elements that match a predicate.
  func getCount(
    _ getIsIncluded: (Element) throws -> Bool
  ) rethrows -> Int {
    try filter(getIsIncluded).count
  }

  /// The number of elements that match a predicate.
  func getCount<Wrapped>(
    _ getIsIncluded: (Wrapped) throws -> Bool
  ) rethrows -> Int
  where Element == Wrapped? {
    try getCount { try $0.map(getIsIncluded) == true }
  }

  /// The first element of a given type.
  func getFirst<T>() -> T? {
    lazy.compactMap { $0 as? T } .first
  }

  /// Alternates between the elements of two sequences.
  /// - Parameter keepSuffix:
  /// When `true`, and the sequences have different lengths,
  /// the suffix of `interleaved`  will be the suffix of the longer sequence.
  func interleaved<Sequence: Swift.Sequence>(
    with sequence: Sequence,
    keepingLongerSuffix keepSuffix: Bool = false
  ) -> AnySequence<Element>
  where Sequence.Element == Element {
    keepSuffix
    ? .init {
      AnyIterator(
        state: (
          AnyIterator( self.makeIterator() ),
          AnyIterator( sequence.makeIterator() )
        )
      ) { iterators in 
        defer { iterators = (iterators.1, iterators.0) }
        return iterators.0.next() ?? iterators.1.next()
      }
    }
    : .init(
      zip(self, sequence).lazy.flatMap { [$0, $1] }
    )
  }

  func max<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable
  ) rethrows -> Element? {
    try self.max {
      try getComparable($0) < getComparable($1)
    }
  }

  /// - Returns: max() for the elements with comparables
  func max<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable?
  ) rethrows -> Element? {
    try getElement(getComparable) { $0.max { $0.0 }? .1 }
  }
  
  func min<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable
  ) rethrows -> Element? {
    try self.min {
      try getComparable($0) < getComparable($1)
    }
  }

  /// - Returns: min() for the elements with comparables
  func min<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable?
  ) rethrows -> Element? {
    try getElement(getComparable) { $0.min { $0.0 }?.1 }
  }

  /// - Returns: `nil` If the sequence has no elements, instead of an "initial result".
  func reduce(
    _ getNextPartialResult: (Element, Element) throws -> Element
  ) rethrows -> Element? {
    guard let first = first
    else { return nil }

    return try dropFirst().reduce(first, getNextPartialResult)
  }

  /// Accumulates transformed elements.
  /// - Returns: `nil`  if the sequence has no elements.
  func reduce<Result>(
    _ transform: (Element) throws -> Result,
    _ getNextPartialResult: (Result, Result) throws -> Result
  ) rethrows -> Result? {
    try lazy.map(transform).reduce(getNextPartialResult)
  }

  private func getElement<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable?,
    _ getElement: ([(Comparable, Element)]) throws -> Element?
  ) rethrows -> Element? {
    let comparablesAndElements = try compactMap { element in
      try getComparable(element).map { comparable in (comparable, element) }
    }

    return try getElement(comparablesAndElements)
  }
  
  func sorted<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable
  ) rethrows -> [Element] {
    try self.sorted(getComparable, <)
  }

  func sorted<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable,
    _ getAreInIncreasingOrder: (Comparable, Comparable) throws -> Bool
  ) rethrows -> [Element] {
    try sorted {
      try getAreInIncreasingOrder( getComparable($0), getComparable($1) )
    }
  }
}

//MARK: Element: Equatable
public extension Sequence where Element: Equatable {
  /// - Note: Has equivalent elements to a `Set`, made from this sequence.
  var firstUniqueElements: [Element] {
    reduce(into: []) { uniqueElements, element in
      if !uniqueElements.contains(element) {
        uniqueElements.append(element)
      }
    }
  }

  /// Whether all elements of the sequence are equal to `element`.
  func containsOnly(_ element: Element) -> Bool {
    allSatisfy { $0 == element }
  }
}

//MARK: Element: Hashable
public extension Sequence where Element: Hashable {
  /// - Note: Has equivalent elements to a `Set`, made from this sequence.
  var firstUniqueElements: [Element] {
    var set: Set<Element> = []
    return filter { set.insert($0).inserted }
  }
}
