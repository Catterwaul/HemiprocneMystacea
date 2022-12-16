import Algorithms

public extension Collection {
  // MARK: - Subscripts

  subscript(indices: some Sequence<Index>) -> some Sequence<Element> {
    indices.lazy.map { self[$0] }
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

  // MARK: - Methods

  /// A sequence made of sequences of elements that have potentially been combined.
  /// - Returns: An empty sequence if this sequence is itself empty.
  @inlinable func accumulated(
    _ canBeAccumulated: @escaping (Element, Element) -> Bool,
    _ accumulate: @escaping (Element, Element) -> Element
  ) -> some Sequence<Element> {
    chunked { !canBeAccumulated($0, $1) }
      .lazy.compactMap { $0.reduce(accumulate) }
  }

  /// Split the collection into a total number of chunks.
  /// - Parameter count:
  ///   If this is not evenly divided by the count of the base `Collection`,
  ///   the last chunk will contain more elements than all of the other chunks.
  func chunks(totalCount: Int) -> some Sequence<SubSequence> {
    let (chunkSize, remainder) = count.quotientAndRemainder(dividingBy: totalCount)
    return chain(
      chunks(ofCount: chunkSize).dropLast(remainder == 0 ? 1 : 2),
      suffix(chunkSize + remainder)
    )
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
