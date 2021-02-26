public extension Sequence {
// MARK:- Operators

  /// Equates two `Sequence`s of 2-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable,
    Tuples1: Sequence
  >(tuples0: Self, tuples1: Tuples1) -> Bool
  where Element == (Equatable0, Equatable1), Tuples1.Element == Element {
    tuples0.elementsEqual(tuples1, by: ==)
  }

  /// Equates two `Sequence`s of 3-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable, Equatable2: Equatable,
    Tuples1: Sequence
  >(tuples0: Self, tuples1: Tuples1) -> Bool
  where Element == (Equatable0, Equatable1, Equatable2), Tuples1.Element == Element {
    tuples0.elementsEqual(tuples1, by: ==)
  }

  /// Equates two `Sequence`s of 4-tuples.
  static func == <
    Equatable0: Equatable, Equatable1: Equatable, Equatable2: Equatable, Equatable3: Equatable,
    Tuples1: Sequence
  >(tuples0: Self, tuples1: Tuples1) -> Bool
  where Element == (Equatable0, Equatable1, Equatable2, Equatable3), Tuples1.Element == Element {
    tuples0.elementsEqual(tuples1, by: ==)
  }

  /// Combines two `Sequence`s.
  static func + <Sequence1: Sequence>(sequence0: Self, sequence1: Sequence1) -> AnySequence<Element>
  where Sequence1.Element == Element {
    .init { () -> AnyIterator<Element> in
      var iterators = (sequence0.makeIterator(), sequence1.makeIterator())
      return .init { iterators.0.next() ?? iterators.1.next() }
    }
  }

// MARK:- Properties

  /// An empty sequence, whose `Element` "would" match this type's.
  static var empty: AnySequence<Element> {
    .init(EmptyCollection.Iterator.init)
  }

  /// Each elements of the sequence, paired with the element after.
  var consecutivePairs: Zip2Sequence<Self, DropFirstSequence<Self>> {
    zip(self, dropFirst())
  }

  /// - Complexity: O(n)
  var count: Int {
    reduce(0) { count, _ in count + 1 }
  }

  /// The first element of the sequence.
  /// - Note: `nil` if the sequence is empty.
  var first: Element? {
    var iterator = makeIterator()
    return iterator.next()
  }

  /// Whether the sequence iterates exactly zero elements.
  var isEmpty: Bool { first == nil }

// MARK:- Subscripts

  /// Splits a `Sequence` into equal "chunks".
  /// - Parameter maxArrayCount: The maximum number of elements in a chunk.
  /// - Returns: `Array`s with `maxArrayCount` `counts`,
  ///   until the last chunk, which may be smaller.
  subscript(maxArrayCount maxCount: Int) -> AnySequence<[Element]> {
    .init(
      sequence(state: makeIterator()) { iterator in
        Optional(
          (0..<maxCount).compactMap { _ in iterator.next() }
        ).filter { !$0.isEmpty }
      }
    )
  }

// MARK:- Methods

  /// `compactMap`, without the `map`!
  func compact<Wrapped>() -> [Wrapped]
  where Element == Wrapped? {
    compactMap { $0 }
  }

  /// The elements of this sequence, and the ones after them.
  /// - Note: Every returned array will have the same count,
  /// so this stops short of the end of the sequence by `count - 1`.
  /// - Precondition: `count > 0`
  func consecutiveElements(by count: Int) -> AnySequence<[Element]> {
    (0..<count).map(Array(self).dropFirst).zipped
  }

  /// The number of elements that match a predicate.
  func count(
    where getIsIncluded: (Element) throws -> Bool
  ) rethrows -> Int {
    try filter(getIsIncluded).count
  }

  /// The number of elements that match a predicate.
  func count<Wrapped>(
    where getIsIncluded: (Wrapped) throws -> Bool
  ) rethrows -> Int
  where Element == Wrapped? {
    try count { try $0.map(getIsIncluded) == true }
  }

  /// The elements of the sequences, with "duplicates" removed
  /// based on a closure.
  func firstUniqueElements<Hashable: Swift.Hashable>(
    _ getHashable: (Element) -> Hashable
  ) -> [Element] {
    var set: Set<Hashable> = []
    return filter { set.insert(getHashable($0)).inserted }
  }

  /// The elements of the sequence, with "duplicates" removed,
  /// based on a closure.
  func firstUniqueElements<Equatable: Swift.Equatable>(
    _ getEquatable: (Element) -> Equatable
  ) -> [Element] {
    reduce(into: []) { uniqueElements, element in
      if zip(
        uniqueElements.lazy.map(getEquatable),
        AnyIterator { [equatable = getEquatable(element)] in equatable }
      ).allSatisfy(!=) {
        uniqueElements.append(element)
      }
    }
  }

  /// The first element of a given type.
  func first<T>(_: T.Type = T.self) -> T? {
    lazy.compactMap { $0 as? T } .first
  }

  /// Group the elements by a transformation into an `Equatable`.
  /// - Note: Similar to `Dictionary(grouping values:)`,
  /// but preserves "key" ordering, and doesn't require hashability.
  func grouped<Equatable: Swift.Equatable>(
    by equatable: (Element) throws -> Equatable
  ) rethrows -> [[Element]] {
    try reduce(into: [(equatable: Equatable, elements: [Element])]()) {
      let equatable = try equatable($1)

      if let index = ( $0.firstIndex { $0.equatable == equatable } ) {
        $0[index].elements.append($1)
      } else {
        $0.append((equatable, [$1]))
      }
    }.map(\.elements)
  }

  /// Alternates between the elements of two sequences.
  /// - Parameter keepSuffix:
  /// When `true`, and the sequences have different lengths,
  /// the suffix of `interleaved`  will be the suffix of the longer sequence.
  func interleaved<Sequence: Swift.Sequence>(
    with sequence: Sequence,
    keepingLongerSuffix keepSuffix: Bool = false
  ) -> AnySequence<Element>
  where Sequence.Element == Element {
    keepSuffix
    ? .init {
      AnyIterator(
        state: (
          AnyIterator(self.makeIterator()),
          AnyIterator(sequence.makeIterator())
        )
      ) { iterators in 
        defer { iterators = (iterators.1, iterators.0) }
        return iterators.0.next() ?? iterators.1.next()
      }
    }
    : .init(
      zip(self, sequence).lazy.flatMap { [$0, $1] }
    )
  }

  func max<Comparable: Swift.Comparable>(
    by getComparable: (Element) throws -> Comparable
  ) rethrows -> Element? {
    try self.max {
      try getComparable($0) < getComparable($1)
    }
  }

  /// - Returns: max() for the elements with comparables
  func max<Comparable: Swift.Comparable>(
    by getComparable: (Element) throws -> Comparable?
  ) rethrows -> Element? {
    try getElement(getComparable) { $0.max { $0.0 }? .1 }
  }
  
  func min<Comparable: Swift.Comparable>(
    by getComparable: (Element) throws -> Comparable
  ) rethrows -> Element? {
    try self.min {
      try getComparable($0) < getComparable($1)
    }
  }

  /// - Returns: min() for the elements with comparables
  func min<Comparable: Swift.Comparable>(
    by getComparable: (Element) throws -> Comparable?
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
  func reduce(
    _ getNextPartialResult: (Element, Element) throws -> Element
  ) rethrows -> Element? {
    try first.map {
      try dropFirst().reduce($0, getNextPartialResult)
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

  /// A sequence of the partial results that `reduce` would employ.
  func scan<Result>(
    _ initialResult: Result,
    _ nextPartialResult: @escaping (Result, Element) -> Result
  ) -> AnySequence<Result> {
    var iterator = makeIterator()
    return .init(
      sequence(first: initialResult) { partialResult in
        iterator.next().map {
          nextPartialResult(partialResult, $0)
        }
      }
    )
  }

  func shifted(by shift: Int) -> AnySequence<Element> {
    shift >= 0
    ? dropFirst(shift) + prefix(shift)
    : suffix(-shift) + dropLast(-shift)
  }

  /// Sorted by a common `Comparable` value.
  func sorted<Comparable: Swift.Comparable>(
    _ comparable: (Element) throws -> Comparable
  ) rethrows -> [Element] {
    try sorted(comparable, <)
  }

  /// Sorted by a common `Comparable` value, and sorting closure.
  func sorted<Comparable: Swift.Comparable>(
    _ comparable: (Element) throws -> Comparable,
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

  func split(includingSeparators getIsSeparator: @escaping (Element) -> Bool)
  -> AnySequence< AnySequence<Element>.Spliteration > {
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

    return .init {
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
}

// MARK: - Element: Sequence
public extension Sequence where Element: Sequence {
  var combinations: [[Element.Element]] {
    guard let initialResult = ( first?.map { [$0] } )
    else { return [] }

    return dropFirst().reduce(initialResult) { combinations, iteration in
      combinations.flatMap { combination in
        iteration.map { combination + [$0] }
      }
    }
  }

  /// Like `zip`, but with no limit to how many sequences are zipped.
  var zipped: AnySequence<[Element.Element]> {
    .init(
      sequence(
        state: map { $0.makeIterator() }
      ) { iterators in
        Optional(
          (iterators.indices).map { iterators[$0].next() }
        )
        .filter { $0.allSatisfy { $0 != nil } }?
        .compact()
      }
    )
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
