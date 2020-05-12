public extension Sequence where Element: Equatable {
  /// - Note: `nil` if empty.
  var elementsAreAllEqual: Bool? {
    first.map(dropFirst().containsOnly)
  }

  /// - Note: Has equivalent elements to a `Set`, made from this sequence.
  var firstUniqueElements: [Element] {
    reduce(into: []) { uniqueElements, element in
      if !uniqueElements.contains(element) {
        uniqueElements.append(element)
      }
    }
  }

  /// Returns only elements that don’t match the previous element.
  var removingDuplicates: AnySequence<Element> {
    guard let first = first
    else { return .empty }

    return .init(
      sequence(first: first) {
        [iterator = AnyIterator( makeIterator() )]
        previous in iterator.first { previous != $0 }
      }
    )
  }

  /// Whether all elements of the sequence are equal to `element`.
  func containsOnly(_ element: Element) -> Bool {
    allSatisfy { $0 == element }
  }

  /// The ranges of in-order elements.
  func ranges<Elements: Sequence>(for elements: Elements) -> [ClosedRange<Int>]
  where Elements.Element == Element {
    let (enumerated, getPrevious) = AnySequence.makeIterator( self.enumerated() )
    return elements.compactMap { element in
      enumerated.first { $0.element == element }
      .map { start in
        start.offset...(
          enumerated.first { $0.element != element }
          .map { $0.offset - 1 }
          ?? {
            let lastOffset = getPrevious()!.offset
            return lastOffset
          } ()
        )
      }
    }
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
