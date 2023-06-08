import Algorithms

public extension Sequence where Element: Equatable {
  /// - Note: `nil` if empty.
  var elementsAreAllEqual: Bool? {
    first.map(dropFirst().containsOnly)
  }

  /// - Note: `true` if `elements` is empty.
  func contains(_ elements: some Sequence<Element>) -> Bool {
    dropIterators.contains {
      AnySequence.zip(IteratorSequence($0), elements)
        .first(where: !=)?.1 == nil
      // If `elements` is longer than this drop-iterator,
      // `.0` will be nil, not `.1`.
    }
  }

  /// The element that precedes the first occurrence of `element`.
  subscript(before element: Element) -> Element? {
    adjacentPairs().first { $0.1 == element }?.0
  }

  /// The element that follows the first occurrence of `element`.
  subscript(after element: Element) -> Element? {
    adjacentPairs().first { $0.0 == element }?.1
  }

  /// Whether this sequence contains all the elements of another, in order.
  func isOrderedSuperset(of elements: some Sequence<Element>) -> Bool {
    elements.allSatisfy(AnyIterator(makeIterator()).contains)
  }

  /// The elements of the sequence, with duplicates removed.
  /// - Note: Has equivalent elements to `Set(self)`.
  var uniqued: [Element] {
    let getSelf: (Element) -> Element = \.self
    return uniqued(on: getSelf)
  }

  /// Returns only elements that don’t match the previous element.
  var removingDuplicates: some Sequence<Element> {
    sequence(state: nil) {
      [iterator = AnyIterator(makeIterator())]
      previous in
      previous = iterator.first { $0 != previous }
      return previous
    }
  }

  /// Whether all elements of the sequence are equal to `element`.
  func containsOnly(_ element: Element) -> Bool {
    allSatisfy { $0 == element }
  }

  /// The ranges of in-order elements.
  func ranges(for elements: some Sequence<Element>) -> [ClosedRange<Int>] {
    let (enumerated, getPrevious) = AnySequence.makeIterator(self.enumerated())
    return elements.compactMap { element in
      enumerated.first { $0.element == element }
      .map { start in
        start.offset...(
          enumerated.first { $0.element != element }
            .map { $0.offset - 1 }
          ?? getPrevious()!.offset
        )
      }
    }
  }
}
