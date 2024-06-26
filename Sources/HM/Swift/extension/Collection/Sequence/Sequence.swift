import Algorithms
import enum Foundation.SortOrder

public extension Sequence {
// MARK:- Operators

  @available(
    swift, deprecated: 6,
    message: "Use `elementsEqual`. Tuples should be `Equatable` now."
  )
  /// Equates two `Sequence`s of 2-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable
  >(tuples0: Self, tuples1: some Sequence<Element>) -> Bool
  where Element == (Equatable0, Equatable1) {
    tuples0.elementsEqual(tuples1, by: ==)
  }

  @available(
    swift, deprecated: 6,
    message: "Use `elementsEqual`. Tuples should be `Equatable` now."
  )
  /// Equates two `Sequence`s of 3-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable, Equatable2: Equatable
  >(tuples0: Self, tuples1: some Sequence<Element>) -> Bool
  where Element == (Equatable0, Equatable1, Equatable2) {
    tuples0.elementsEqual(tuples1, by: ==)
  }

  @available(
    swift, deprecated: 6,
    message: "Use `elementsEqual`. Tuples should be `Equatable` now."
  )
  /// Equates two `Sequence`s of 4-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable, Equatable2: Equatable, Equatable3: Equatable
  >(tuples0: Self, tuples1: some Sequence<Element>) -> Bool
  where Element == (Equatable0, Equatable1, Equatable2, Equatable3) {
    tuples0.elementsEqual(tuples1, by: ==)
  }

// MARK:- Properties

  /// An empty sequence, whose `Element` "would" match this type's.
  static var empty: some Sequence<Element> {
    IteratorSequence(EmptyCollection.Iterator())
  }

  /// - Complexity: O(n)
  var count: Int {
    reduce(0) { count, _ in count + 1 }
  }

  /// The iterators of all subsequences, incrementally dropping early elements.
  /// - Note: Begins with the iterator for the full sequence (dropping zero).
  @inlinable var dropIterators: some Sequence<Iterator> {
    withDropIterators.lazy.map(\.1)
  }

  /// Like `zip`ping with the iterators of all subsequences, incrementally dropping early elements.
  /// - Note: Begins with the iterator for the full sequence (dropping zero).
  @inlinable var withDropIterators: some Sequence<(Element, Iterator)> {
    sequence(state: makeIterator()) {
      let iterator = $0
      return $0.next().map { ($0, iterator) }
    }
  }

  /// The first element of the sequence.
  /// - Note: `nil` if the sequence is empty.
  var first: Element? {
    var iterator = makeIterator()
    return iterator.next()
  }

  /// The last element of the sequence.
  /// - Precondition: The sequence is finite.
  /// - Note: `nil` if the sequence is empty.
  var last: Element? { reduce { $1 } }

  /// Whether the sequence iterates exactly zero elements.
  var isEmpty: Bool { first == nil }

  /// Iterated normally, but after the iterator is exhausted: infinite `nil`s.
  @inlinable var padded: some Sequence<Element?> {
    sequence(state: makeIterator()) { $0.next() as Element?? }
  }

// MARK:- Subscripts

  /// Splits a `Sequence` into equal "chunks".
  /// - Parameter maxArrayCount: The maximum number of elements in a chunk.
  /// - Returns: `Array`s with `maxArrayCount` `counts`,
  ///   until the last chunk, which may be smaller.
  subscript(maxArrayCount maxCount: Int) -> some Sequence<[Element]> {
    sequence(state: makeIterator()) { iterator in
      Optional(
        `repeat`(count: maxCount).compactMap { iterator.next() }
      ).filter { !$0.isEmpty }
    }
  }

  /// - Precondition: The indices must be sorted, and non-negative.
  subscript(sorted indices: some Sequence<Int>) -> some Sequence<Element> {
    var iterator = makeIterator()
    return indices.differences.mapUntilNil {
      if case let skipCount = $0 - 1, skipCount > 0 {
        `repeat`(count: skipCount).forEach { iterator.iterate() }
      }
      return iterator.next()
    }
  }

// MARK: - Methods

  /// A sequence made of sequences of elements that have potentially been combined.
  /// - Returns: An empty sequence if this sequence is itself empty.
  @inlinable func accumulated(
    _ accumulate: @escaping (Element, Element) -> Element?
  ) -> some Sequence<Element> {
    sequence(state: CurrentValueIterator(self)) { iterator in
      guard let accumulation = iterator.value else { return nil }

      return withoutActuallyEscaping({ iterator.next() }) { next in
        sequence(first: accumulation) { accumulation in
          next().flatMap { accumulate(accumulation, $0) }
        }.last
      }
    }
  }

  /// The elements of this sequence, and the ones after them.
  /// - Note: Every returned array will have the same count,
  /// so this stops short of the end of the sequence by `count - 1`.
  /// - Precondition: `count > 0`
  func windows(ofCount count: Int) -> some Sequence<
    CompactedSequence<[Element?], Element>
  > {
    (0..<count).map(Array(self).dropFirst).transposed
  }

  /// The number of elements that match a predicate.
  func count(
    where getIsIncluded: (Element) throws -> Bool
  ) rethrows -> Int {
    try lazy.filter(getIsIncluded).count
  }

  /// Distribute the elements as uniformly as possible, as if dealing one-by-one into shares.
  /// - Note: Later shares will be one smaller if the element count is not a multiple of `shareCount`.
  @inlinable func distributedUniformly(shareCount: Int)
  -> LazyMapSequence<Range<Int>, StridingSequence<DropFirstSequence<Self>>> {
    (0..<shareCount).lazy.map {
      dropFirst($0).striding(by: shareCount)
    }
  }
  
  /// Distribute the elements as uniformly as possible, as if dealing one-by-one into shares.
  /// - Note: Later shares will be one smaller if the element count is not a multiple of `shareCount`.
  @inlinable func distributedUniformly(shareCount: Int) -> [[Element]] {
    .init(distributedUniformly(shareCount: shareCount).map(Array.init))
  }

  /// - Parameters:
  ///   - comparable: The property to compare.
  ///   - areSorted: Whether the elements are in order, approaching the extremum.
  func extremum<Comparable: Swift.Comparable>(
    comparing comparable: (Element) throws -> Comparable,
    areSorted: (Comparable, Comparable) throws -> Bool
  ) rethrows -> Extremum<Element>? {
    try first.map { first in
      try dropFirst().reduce(into: .init(value: first, count: 1)) {
        let comparables = (try comparable($0.value), try comparable($1))

        if try areSorted(comparables.0, comparables.1) {
          $0 = .init(value: $1, count: 1)
        } else if (comparables.0 == comparables.1) {
          $0.count += 1
        }
      }
    }
  }

  /// The elements of the sequence, with "duplicates" removed,
  /// based on a closure.
  @inlinable func uniqued(
    on getEquatable: (Element) throws -> some Equatable
  ) rethrows -> [Element] {
    try reduce(into: []) { uniqueElements, element in
      if zip(
        try uniqueElements.lazy.map(getEquatable),
        AnyIterator { [equatable = try getEquatable(element)] in equatable }
      ).allSatisfy(!=) {
        uniqueElements.append(element)
      }
    }
  }

  /// Group the elements by a transformation into a `Key`.
  /// - Note: Similar to `Dictionary(grouping values:)`,
  /// but preserves "key" ordering, and doesn't require hashability.
  func grouped<Key: Equatable>(
    by key: (Element) throws -> Key
  ) rethrows -> [KeyValuePairs<Key, [Element]>.Element] {
    try reduce(into: []) {
      let key = try key($1)

      if let index = ($0.firstIndex { $0.key == key }) {
        $0[index].value.append($1)
      } else {
        $0.append((key, [$1]))
      }
    }
  }

  /// Alternates between the elements of two sequences.
  /// - Parameter keepSuffix:
  /// When `true`, and the sequences have different lengths,
  /// the suffix of `interleaved`  will be the suffix of the longer sequence.
  func interleaved(
    with sequence: some Sequence<Element>,
    keepingLongerSuffix keepSuffix: Bool = false
  ) -> any Swift.Sequence<Element> {
    keepSuffix
    ? AnyIterator(
        state: (
          AnyIterator(self.makeIterator()),
          AnyIterator(sequence.makeIterator())
        )
      ) { iterators in 
        defer { iterators = (iterators.1, iterators.0) }
        return iterators.0.next() ?? iterators.1.next()
      }
    : zip(self, sequence).lazy.flatMap { [$0, $1] }
  }

  /// Transform this sequence into key-value pairs.
  @inlinable func keyed<Key: Hashable>(
    by key: (Element) throws -> Key
  ) rethrows -> some Sequence<KeyValuePairs<Key, Element>.Element> {
    try lazy.map { (try key($0), $0) }
  }

  func max(
    by getComparable: (Element) throws -> some Comparable
  ) rethrows -> Element? {
    try self.max {
      try getComparable($0) < getComparable($1)
    }
  }

  /// Transform this sequence until encountering a "`nil`".
  func mapUntilNil<Transformed>(
    _ transform: @escaping (Element) -> Transformed?
  ) -> some Sequence<Transformed> {
    sequence(state: makeIterator()) {
      $0.next().flatMap(transform)
    }
  }

  /// - Returns: max() for the elements with comparables
  func max(
    by getComparable: (Element) throws -> (some Comparable)?
  ) rethrows -> Element? {
    try getElement(getComparable) { $0.max { $0.0 }? .1 }
  }
  
  func min(
    by getComparable: (Element) throws -> some Comparable
  ) rethrows -> Element? {
    try self.min {
      try getComparable($0) < getComparable($1)
    }
  }

  /// - Returns: min() for the elements with comparables
  func min(
    by getComparable: (Element) throws -> (some Comparable)?
  ) rethrows -> Element? {
    try getElement(getComparable) { $0.min { $0.0 }?.1 }
  }

  /// The only match for a predicate.
  /// - Throws: `AnySequence<Element>.OnlyMatchError`
  func onlyMatch(for getIsMatch: (Element) throws -> Bool) throws -> Element {
    typealias Error = AnySequence<Element>.OnlyMatchError
    guard let onlyMatch: Element = (
      try reduce(into: nil) { onlyMatch, element in
        switch (onlyMatch, try getIsMatch(element)) {
        case (_, false):
          break
        case (nil, true):
          onlyMatch = element
        case (.some, true):
          throw Error.moreThanOneMatch
        }
      }
    ) else { throw Error.noMatches }

    return onlyMatch
  }
  
  /// Like `prefix(while:)`, but including one more element.
  @inlinable func prefixThroughFirst(
    where predicate: @escaping (Element) -> Bool
  ) -> some Sequence<Element> {
    sequence(state: (iterator: makeIterator(), finished: false)) {
      guard
        !$0.finished,
        let next = $0.iterator.next()
      else { return nil }
      
      if predicate(next) { $0.finished = true }
      return next
    }
  }

  /// `reduce`, disregarding all sequence elements.
  @inlinable func reduce<Result>(
    _ initialResult: Result,
    _ nextPartialResult: (_ partialResult: Result) throws -> Result
  ) rethrows -> Result {
    try reduce(initialResult) { partialResult, _ in
      try nextPartialResult(partialResult)
    }
  }

  /// `reduce`, disregarding all sequence elements.
  @inlinable func reduce<Result>(
    into initialResult: Result,
    _ updateAccumulatingResult: (_ partialResult: inout Result) throws -> Void
  ) rethrows -> Result {
    try reduce(into: initialResult) { partialResult, _ in
      try updateAccumulatingResult(&partialResult)
    }
  }

  /// - Returns: `nil` If the sequence has no elements, instead of an "initial result".
  @inlinable func reduce(
    _ nextPartialResult: (Element, Element) throws -> Element
  ) rethrows -> Element? {
    var iterator = makeIterator()
    return try iterator.next().map { first in
      try IteratorSequence(iterator).reduce(first, nextPartialResult)
    }
  }

  /// Accumulates transformed elements.
  /// - Returns: `nil`  if the sequence has no elements.
  func reduce<Result>(
    _ transform: (Element) throws -> Result,
    _ getNextPartialResult: (Result, Result) throws -> Result
  ) rethrows -> Result? {
    try lazy.map(transform).reduce(getNextPartialResult)
  }

  private func getElement<Comparable: Swift.Comparable>(
    _ getComparable: (Element) throws -> Comparable?,
    _ getElement: ([(Comparable, Element)]) throws -> Element?
  ) rethrows -> Element? {
    let comparablesAndElements = try compactMap { element in
      try getComparable(element).map { comparable in (comparable, element) }
    }

    return try getElement(comparablesAndElements)
  }

  func shifted(by shift: Int) -> any Sequence<Element> {
    shift >= 0
    ? chain(dropFirst(shift), prefix(shift))
    : chain(suffix(-shift), dropLast(-shift))
  }

  func split(includingSeparators getIsSeparator: @escaping (Element) -> Bool)
  -> some Sequence< AnySequence<Element>.Spliteration > {
    var separatorFromPrefixIteration: Element?

    func process(next: Element?) -> Void {
      separatorFromPrefixIteration =
        next.map(getIsSeparator) == true
        ? next
        : nil
    }

    process(next: first)
    let prefixIterator = AnyIterator(
      dropFirst(
        separatorFromPrefixIteration == nil
        ? 0
        : 1
      ),
      processNext: process
    )

    return AnySequence {
      if let separator = separatorFromPrefixIteration {
        separatorFromPrefixIteration = nil
        return .separator(separator)
      }

      return
        Optional(
          prefixIterator.prefix { !getIsSeparator($0) }
        )
        .filter { !$0.isEmpty }
        .map(AnySequence.Spliteration.subSequence)
    }
  }

  /// - throws: `Extremum<Element>.UniqueError`
  func uniqueMin(
    comparing comparable: (Element) throws -> some Comparable
  ) throws -> Extremum<Element> {
    typealias Error = Extremum<Element>.UniqueError

    guard let extremum = try extremum(comparing: comparable, areSorted: >)
    else { throw Error.emptySequence }

    guard extremum.count == 1
    else { throw Error.notUnique(extremum) }

    return extremum
  }

  // MARK: -

  /// Whether the elements of this sequence are sorted by a common `Comparable` value.
  @inlinable func isSorted(
    by comparable: (Element) throws -> some Comparable
  ) rethrows -> Bool {
    try isSorted(by: comparable, <=)
  }

  /// Whether the elements of this sequence are sorted by a common `Comparable` value,
  /// and sorting closure.
  @inlinable func isSorted<Comparable: Swift.Comparable>(
    by comparable: (Element) throws -> Comparable,
    _ areInIncreasingOrder: (Comparable, Comparable) throws -> Bool
  ) rethrows -> Bool {
    try adjacentPairs().allSatisfy {
      try areInIncreasingOrder(comparable($0), comparable($1))
    }
  }

  /// Sorted by a common `Comparable` value.
  func sorted(
    by comparable: (Element) throws -> some Comparable
  ) rethrows -> [Element] {
    try sorted(by: comparable, <)
  }

  /// Sorted by a common `Comparable` value, and sorting closure.
  func sorted<Comparable: Swift.Comparable>(
    by comparable: (Element) throws -> Comparable,
    _ areInIncreasingOrder: (Comparable, Comparable) throws -> Bool
  ) rethrows -> [Element] {
    try sorted {
      try areInIncreasingOrder(comparable($0), comparable($1))
    }
  }

  /// Sorted by two common `Comparable` values.
  func sorted<Comparable0: Comparable, Comparable1: Comparable>(
    _ comparables: (Element) throws -> (Comparable0, Comparable1)
  ) rethrows -> [Element] {
    try sorted(comparables, <)
  }

  /// Sorted by two common `Comparable` values, and sorting closure.
  func sorted<Comparable0: Comparable, Comparable1: Comparable>(
    _ comparables: (Element) throws -> (Comparable0, Comparable1),
    _ areInIncreasingOrder: ((Comparable0, Comparable1), (Comparable0, Comparable1)) throws -> Bool
  ) rethrows -> [Element] {
    try sorted {
      try areInIncreasingOrder(comparables($0), comparables($1))
    }
  }

  func sorted<Comparable0: Comparable, Comparable1: Comparable>(
    orders: (SortOrder, SortOrder),
    _ comparables: (Element) throws -> (Comparable0, Comparable1)
  ) rethrows -> [Element] {
    try sorted {
      let comparables = try (comparables($0), comparables($1))
      switch orders {
      case (.forward, .forward):
        return comparables.0 < comparables.1
      case (.forward, .reverse):
        return (comparables.0.0, comparables.1.1) < (comparables.1.0, comparables.0.1)
      case (.reverse, .forward):
        return (comparables.1.0, comparables.0.1) < (comparables.0.0, comparables.1.1)
      case (.reverse, .reverse):
        return (comparables.1.0, comparables.1.1) < (comparables.0.0, comparables.0.1)
      }
    }
  }
}

/// Recursively apply a transformation until it is no longer possible.
@inlinable public func root<T>(_ first: T, _ next: (T) -> T?) -> T {
  withoutActuallyEscaping(next) {
    sequence(first: first, next: $0).last!
  }
}

/// Recursively collect the elements of sequences.
@inlinable public func recursive<Root>(
  _ root: Root,
  _ children: (Root) -> some Sequence<Root>
) -> some Sequence<Root> {
  chain(
    root,
    children(root).flatMap { recursive($0, children) }
  )
}

// MARK: - Element: Sequence
public extension Sequence where Element: Sequence {
  var combinations: [[Element.Element]] {
    guard let initialResult = (first?.map { [$0] })
    else { return [] }

    return dropFirst().reduce(initialResult) { combinations, iteration in
      combinations.flatMap { combination in
        iteration.map { combination + [$0] }
      }
    }
  }

  /// Like `zip`, but with no limit to how many sequences are zipped.
  var transposed: some Sequence<
    CompactedSequence<[Element.Element?], Element.Element>
  > {
    sequence(state: map { $0.makeIterator() }) { iterators in
      iterators.indices.lazy.map { iterators[$0].next() }
        .compactedIfAllAreSome()
    }
  }
}

// MARK: -

public extension Array {
  init(_ spliteration: AnySequence<Element>.Spliteration) {
    switch spliteration {
    case .separator(let separator):
      self = [separator]
    case .subSequence(let array):
      self = array
    }
  }
}

public struct Extremum<Value> {
  public enum UniqueError: Swift.Error {
    case emptySequence
    case notUnique(Extremum)
  }

  public var value: Value
  public var count: Int
}

/// A sequence of `Void`s that terminates when `predicate` returns `false`.
@inlinable public func `while`(_ predicate: @escaping () -> Bool)
-> some Sequence<Void> {
  sequence(state: ()) {
    predicate() ? $0 : nil
  }
}

/// An infinite sequence of a single value.
@inlinable public func sequence<Element>(_ element: Element) -> some Sequence<Element> {
  let getSelf: (Element) -> Element = \.self
  return sequence(first: element, next: getSelf)
}

/// An infinite sequence producing no values.
@inlinable public func sequence() -> some Sequence<Void> {
  sequence(())
}
