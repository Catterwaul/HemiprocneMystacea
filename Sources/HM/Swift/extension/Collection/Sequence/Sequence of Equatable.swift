import OrderedCollections

public extension Sequence where Element: Equatable {
  /// - Note: `nil` if empty.
  var elementsAreAllEqual: Bool? {
    first.map(dropFirst().containsOnly)
  }

  /// - Note: `false` if `elements` is empty.
  func contains<Elements: Sequence>(inOrder elements: Elements) -> Bool
  where Elements.Element == Element {
    elements.isEmpty
      ? false
      : withDropIterators.contains {
        AnySequence(zip: (IteratorSequence($1), elements))
          .first(where: !=)?.1 == nil
      }
  }

  /// The element that follows.
  func callAsFunction(after element: Element) -> Element? {
    var iterator = makeIterator()
    while iterator.next() != element { }
    return iterator.next()
  }

  /// Whether this sequence contains all the elements of another, in order.
  func isOrderedSuperset<Elements: Sequence>(of elements: Elements) -> Bool
  where Elements.Element == Element {
    elements.allSatisfy(AnyIterator(makeIterator()).contains)
  }

  /// The elements of the sequence, with duplicates removed.
  /// - Note: Has equivalent elements to `Set(self)`.
  @available(
    swift, deprecated: 5.8,
    message: "Doesn't compile without the constant in Swift 5.7."
  )
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
  func ranges<Elements: Sequence>(for elements: Elements) -> [ClosedRange<Int>]
  where Elements.Element == Element {
    let (enumerated, getPrevious) = AnySequence.makeIterator(self.enumerated())
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

// MARK: Element: Hashable
public extension Sequence where Element: Hashable {
  var containsOnlyUniqueElements: Bool {
    do {
      _ = try Set(unique: self)
      return true
    } catch {
      return false
    }
  }

  /// The non-unique elements of this collection, in the order of their first occurrences.
  var duplicates: OrderedSet<Element> {
    OrderedDictionary(bucketing: self).filter { $1 > 1 }.keys
  }

  /// The unique elements of this collection, in the order of their first occurrences.
  func uniqueElements() -> some Sequence<Element> {
    OrderedDictionary(bucketing: self)
      .lazy
      .filter { $0.value == 1 }
      .map(\.key)
  }

  /// The unique elements of this collection, in the order of their first occurrences.
  @_disfavoredOverload func uniqueElements() -> OrderedSet<Element> {
    OrderedDictionary(bucketing: self)
      .filter { $0.value == 1 }
      .keys
  }

  /// Matches interleaved subsequences of identical elements with separate iterations of some other sequence.
  func withKeyedIterations<Sequence: Swift.Sequence>(of sequence: Sequence)
  -> [(Element, Sequence.Element)] {
    var iterators: [Element: Sequence.Iterator] = [:]
    return map {
      ($0, iterators[$0, default: sequence.makeIterator()].next()!)
    }
  }
}
