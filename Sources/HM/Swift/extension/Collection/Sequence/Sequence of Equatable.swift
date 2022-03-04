public extension Sequence where Element: Equatable {
  /// The iterators of all subsequences, incrementally dropping early elements.
  /// - Note: Begins with the iterator for the full sequence (dropping zero).
  var dropIterators: AnySequence<AnyIterator<Element>> {
    .init(
      sequence(state: makeIterator()) {
        let iterator = $0
        return $0.next().map { _ in .init(iterator) }
      }
    )
  }

  /// - Note: `nil` if empty.
  var elementsAreAllEqual: Bool? {
    first.map(dropFirst().containsOnly)
  }

  /// - Note: `false` if `elements` is empty.
  func contains<Elements: Sequence>(inOrder elements: Elements) -> Bool
  where Elements.Element == Element {
    elements.isEmpty
      ? false
      : dropIterators.contains {
        AnySequence(zip: ($0, elements))
          .first(where: !=)?.1 == nil
      }
  }

  /// The elements of the sequence, with duplicates removed.
  /// - Note: Has equivalent elements to `Set(self)`.
  @available(
    swift, deprecated: 5.7,
    message: "Doesn't compile without the constant in Swift 5.5."
  )
  var uniqued: [Element] {
    let getSelf: (Element) -> Element = \.self
    return uniqued(on: getSelf)
  }

  /// Returns only elements that don’t match the previous element.
  var removingDuplicates: AnySequence<Element> {
    guard let first = first
    else { return .empty }

    return .init(
      sequence(first: first) {
        [iterator = AnyIterator(makeIterator())]
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

  /// Matches interleaved subsequences of identical elements with seperate iterations of some other sequence.
  func withKeyedIterations<Sequence: Swift.Sequence>(of sequence: Sequence)
  -> [(Element, Sequence.Element)] {
    var iterators: [Element: Sequence.Iterator] = [:]
    return map {
      ($0, iterators[$0, default: sequence.makeIterator()].next()!)
    }
  }
}
