import Algorithms

public extension Collection {
  // MARK: - Subscripts

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

  // MARK: - Methods
  /// Ensure an index is valid before accessing an element of the collection.
  /// - Returns: The same as the unlabeled subscript, if an error is not thrown.
  /// - Throws: `AnyCollection<Element>.IndexingError`
  ///   if `indices` does not contain `index`.
  subscript(validating index: Index) -> Element {
    get throws {
      guard indices.contains(index)
      else { throw AnyCollection<Element>.IndexingError() }
      
      return self[index]
    }
  }

  /// - Note: The first "half" will be longer by one element,
  /// if `count` is odd.
  var splitInHalf: ChunksOfCountCollection<Self> {
    let (halfCount, remainder) = count.quotientAndRemainder(dividingBy: 2)
    return chunks(ofCount: halfCount + remainder)
  }

  /// Remove the beginning or end of a `Collection`.
  /// - Parameters:
  ///   - adfix: A prefix or suffix.
  ///   - hasAdfix: Whether a collection is adfixed by `adfix`.
  ///   - drop: Create a `SubSequence` by removing…
  ///    - count: …this many `Element`s.
  /// - Returns: `nil` if `hasAffix(affix)` is `false`.
  func without<Adfix: Sequence<Element>>(
    adfix: Adfix,
    hasAdfix: (Adfix) -> Bool,
    drop: (_ count: Int) -> SubSequence
  ) -> SubSequence? {
    guard hasAdfix(adfix) else { return nil }

    return drop(adfix.count)
  }
}

public extension Collection where Element: Equatable {
// MARK: - Subscripts
  
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

// MARK: - Methods

  ///- Returns: nil if `element` isn't present
  func prefix(upTo element: Element) -> SubSequence? {
    firstIndex(of: element).map(prefix(upTo:))
  }

  ///- Returns: nil if `element` isn't present
  func prefix(through element: Element) -> SubSequence? {
    firstIndex(of: element).map(prefix(through:))
  }
}

public extension Collection where SubSequence: RangeReplaceableCollection {
  func shifted(by shift: Int) -> SubSequence {
    shift >= 0
    ? dropFirst(shift) + prefix(shift)
    : suffix(-shift) + dropLast(-shift)
  }
}
