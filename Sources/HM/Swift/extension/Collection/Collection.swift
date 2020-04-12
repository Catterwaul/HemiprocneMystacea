public extension Collection {
//MARK:- Subscripts

  /// Splits a `Collection` into equal "chunks".
  /// - Parameter maxSubSequenceCount: The maximum number of elements in a chunk.
  /// - Returns: `SubSequence`s with `maxSubSequenceLength` `counts`,
  ///   until the last chunk, which may be smaller.
  subscript(maxSubSequenceCount maxCount: Int) -> AnyIterator<SubSequence> {
    .init(state: startIndex) { startIndex in
      guard startIndex < self.endIndex
      else { return nil }

      let endIndex =
        self.index(startIndex, offsetBy: maxCount, limitedBy: self.endIndex)
        ?? self.endIndex
      defer { startIndex = endIndex }
      return self[startIndex..<endIndex]
    }
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

//MARK:- Functions

  /// - Returns: same as subscript, if index is in bounds
  /// - Throws: CollectionIndexingError
  func getElement(index: Index) throws -> Element {
    guard indices.contains(index)
    else { throw CollectionIndexingError() }

    return self[index]
  }
}

/// Thrown when `getElement` is called with an invalid index.
public struct CollectionIndexingError: Error { }

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

//MARK:- Functions

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
    let drops =
      shift > 0
      ? (shift, count - shift)
      : (count + shift, -shift)
    return dropFirst(drops.0) + dropLast(drops.1)
  }
}
