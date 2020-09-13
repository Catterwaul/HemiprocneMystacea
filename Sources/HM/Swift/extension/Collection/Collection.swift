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

  //MARK: - Methods

  /// - Returns: same as subscript, if index is in bounds
  /// - Throws: `AnyCollection<Element>.IndexingError`
  func element(at index: Index) throws -> Element {
    guard indices.contains(index)
    else { throw AnyCollection<Element>.IndexingError() }

    return self[index]
  }

  /// Remove the beginning or end of a `Collection`.
  /// - Parameters:
  ///   - adfix: A prefix or suffix.
  ///   - hasAdfix: Whether a collection is adfixed by `adfix`.
  ///   - drop: Create a `SubSequence` by removing…
  ///    - count: …this many `Element`s.
  /// - Returns: `nil` if `hasAffix(affix)` is `false`.
  func without<Adfix: Sequence>(
    adfix: Adfix,
    hasAdfix: (Adfix) -> Bool,
    drop: (_ count: Int) -> SubSequence
  ) -> SubSequence?
  where Element == Adfix.Element {
    guard hasAdfix(adfix)
    else { return nil }

    return drop(adfix.count)
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
}

public extension Collection where SubSequence: RangeReplaceableCollection {
  func shifted(by shift: Int) -> SubSequence {
    shift >= 0
    ? dropFirst(shift) + prefix(shift)
    : suffix(-shift) + dropLast(-shift)
  }
}
