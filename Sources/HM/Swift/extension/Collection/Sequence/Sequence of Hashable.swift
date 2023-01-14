import OrderedCollections

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

  /// A version of this sequence without the earliest occurrences of all `elementsToRemove`.
  ///
  /// If `elementsToRemove` contains multiple equivalent values,
  /// that many of the earliest occurrences will be filtered out.
  func filteringOutEarliestOccurrences(from elementsToRemove: some Sequence<Element>) -> some Sequence<Element> {
    var elementCounts = Dictionary(bucketing: elementsToRemove)
    return lazy.filter {
      do {
        try elementCounts.remove(countedSetElement: $0)
        return false
      } catch {
        return true
      }
    }
  }
}
