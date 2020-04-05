public extension Sequence {
  var consecutivePairs: Zip2Sequence< Self, DropFirstSequence<Self> > {
    zip( self, dropFirst() )
  }

  /// The first element of the sequence.
  /// - Note: `nil` if the sequence is empty.
  var first: Element? {
    var iterator = makeIterator()
    return iterator.next()
  }

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

//MARK: containsOnly
public extension Sequence where Element: Equatable {
  ///- Returns: whether all elements of the sequence are equal to `element`
  func containsOnly(_ element: Element) -> Bool {
    allSatisfy { $0 == element }
  }
}

//MARK: uniqueElements
public extension Sequence where Element: Hashable {
  /// - Note: Has equivalent elements to a `Set`, made from this sequence.
  var firstUniqueElements: [Element] {
    var set: Set<Element> = []
    return filter { set.insert($0).inserted }
  }
}

public extension Sequence where Element: Equatable {
  /// - Note: Has equivalent elements to a `Set`, made from this sequence.
  var firstUniqueElements: [Element] {
    reduce(into: []) { uniqueElements, element in
      if !uniqueElements.contains(element) {
        uniqueElements.append(element)
      }
    }
  }
}
