public extension Sequence {
  var consecutivePairs: Zip2Sequence< Self, DropFirstSequence<Self> > {
    zip( self, dropFirst() )
  }

  var first: Element? { first { _ in true } }
  
  func max<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable
  ) rethrows -> Element? {
    try self.max {
      try getComparable($0) < getComparable($1)
    }
  }

  /// - Returns: max() for the elements with comparables
  func max<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable?
  ) rethrows -> Element? {
    try getElement(
      getComparable: getComparable,
      getElement: { $0.max { $0.0 }? .1 }
    )
  }
  
  func min<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable
  ) rethrows -> Element? {
    try self.min {
      try getComparable($0) < getComparable($1)
    }
  }

  /// - Returns: min() for the elements with comparables
  func min<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable?
  ) rethrows -> Element? {
    try getElement(
      getComparable: getComparable,
      getElement: { $0.min { $0.0 }? .1 }
    )
  }

  private func getElement<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable?,
    getElement: ([(Comparable, Element)]) throws -> Element?
  ) rethrows -> Element? {
    let comparablesAndElements = try compactMap { element in
      try getComparable(element).map { comparable in (comparable, element) }
    }

    return try getElement(comparablesAndElements)
  }
  
  func sorted<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable
  ) rethrows -> [Element] {
    try self.sorted { try getComparable($0) < getComparable($1) }
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
	var uniqueElements: [Element] { Array( Set(self) ) }
}

public extension Sequence where Element: Equatable {
  var uniqueElements: [Element] {
    reduce(into: []) { uniqueElements, element in
      if !uniqueElements.contains(element) {
        uniqueElements.append(element)
      }
    }
  }
}
