public extension Collection {
//MARK:- Subscripts

  /// Splits a `Collection` into equal "chunks".
  /// - Parameter maxSubSequenceCount: The maximum number of elements in a chunk.
  /// - Returns: `SubSequence`s with `maxSubSequenceLength` `counts`,
  ///   until the last chunk, which may be smaller.
  subscript(maxSubSequenceCount maxCount: Int) -> AnySequence<SubSequence> {
    .init(
      sequence(state: startIndex) { startIndex in
        guard startIndex < self.endIndex
        else { return nil }

        let endIndex =
          self.index(startIndex, offsetBy: maxCount, limitedBy: self.endIndex)
          ?? self.endIndex
        defer { startIndex = endIndex }
        return self[startIndex..<endIndex]
      }
    )
  }

  /// Circularly wraps `index`, to always provide an element,
  /// even when `index` is not valid.
  subscript(modulo index: Index) -> Element {
    self[
      self.index(
        startIndex,
        offsetBy:
          distance(from: startIndex, to: index)
          .modulo(count)
      )
    ]
  }

  /// - Complexity: O(`position`)
  subscript(startIndexOffsetBy position: Int) -> Element {
    self[index(startIndex, offsetBy: position)]
  }

//MARK:- Methods

  /// - Returns: same as subscript, if index is in bounds
  /// - Throws: `AnyCollection<Element>.IndexingError`
  func element(at index: Index) throws -> Element {
    guard indices.contains(index)
    else { throw AnyCollection<Element>.IndexingError() }

    return self[index]
  }
}

public extension Collection where Element: Equatable {
//MARK:- Subscripts
  
  /// Circularly wraps `index`, to always provide an element,
  /// even when `index` is not valid.
  subscript(
    _ element: Element,
    moduloOffset offset: Int
  ) -> Element? {
    firstIndex(of: element).map {
      self[modulo: index($0, offsetBy: offset)]
    }
  }

//MARK:- Methods

  ///- Returns: nil if `element` isn't present
  func prefix(upTo element: Element) -> SubSequence? {
    firstIndex(of: element).map( prefix(upTo:) )
  }

  ///- Returns: nil if `element` isn't present
  func prefix(through element: Element) -> SubSequence? {
    firstIndex(of: element).map( prefix(through:) )
  }
  
  ///- Returns: nil if `element` isn't present
  func suffix(from element: Element) -> SubSequence? {
    firstIndex(of: element)
    .map { suffix( from: index(after: $0) ) }
  }
}

public extension Collection where SubSequence: RangeReplaceableCollection {
  func shifted(by shift: Int) -> SubSequence {
    shift >= 0
    ? dropFirst(shift) + prefix(shift)
    : suffix(-shift) + dropLast(-shift)
  }
}
