import Algorithms
import OrderedCollections

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
  func ranges(for elements: some Sequence<Element>) -> [ClosedRange<Int>] {
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
