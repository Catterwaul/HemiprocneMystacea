import Algorithms

public extension Comparable {
  /// - Parameters maximum: A transformation of `minimum`.
  static func ... (minimum: Self, maximum: (Self) -> Self) -> ClosedRange<Self> {
    minimum...maximum(minimum)
  }

  /// - Parameters maximum: A transformation of `minimum`.
  static func ..< (minimum: Self, maximum: (Self) -> Self) -> Range<Self> {
    minimum..<maximum(minimum)
  }

  /// The properties with the maximum value.
  /// - Parameter subject: An instance of any type.
  /// - Returns: `nil` if no value matches the `Comparable` type.
  static func max(
    ofPropertiesOf subject: some Any
  ) -> (labels: [String], value: Self)? {
    max(ofPropertiesOf: subject, by: <)
  }

  /// The properties with the maximum value.
  /// - Parameters:
  ///   - subject: An instance of any type.
  ///   - getAreInIncreasingOrder: Sorts two values.
  /// - Returns: `nil` if no value matches the `Comparable` type.
  static func max(
    ofPropertiesOf subject: some Any,
    by getAreInIncreasingOrder: (Self, Self) throws -> Bool
  ) rethrows -> (labels: [String], value: Self)? {
    let comparableChildren =
      Mirror(reflecting: subject).children
      .compactMap { child in
        (child.value as? Self).map {
          (label: child.label, value: $0)
        }
      }

    guard let maxValue = try
      comparableChildren.map(\.value)
      .max(by: getAreInIncreasingOrder)
    else { return nil }

    return (
      comparableChildren
        .filter { $0.value == maxValue }
        .compactMap(\.label),
      maxValue
    )
  }

  func clamped(to limits: ClosedRange<Self>) -> Self {
    min(Swift.max(limits.lowerBound, self), limits.upperBound)
  }

  /// Like `<`, but with a default for the case when `==` evaluates to `true`.
  func isLessThan(
    _ comparable: Self,
    whenEqual default: @autoclosure () -> Bool
  ) -> Bool {
    self == comparable
    ? `default`()
    : self < comparable
  }
}

public extension Sequence where Element: Comparable {
  /// Whether the elements of this sequence are in order.
  @inlinable var isSorted: Bool { adjacentPairs().allSatisfy(<) }

  var localExtrema: (minima: [Element], maxima: [Element]) {
    let dictionary = Dictionary<ExtremumOption, [Element]>(
      grouping:
        removingDuplicates.windows(ofCount: 3).compactMap { consecutiveElements in
          let consecutiveElements = Array(consecutiveElements)
          let value = consecutiveElements[1]

          guard let extremum: ExtremumOption = ( {
            [neighbors = [0, 2].map { consecutiveElements[$0] }] in
            switch value {
            case let minimum where neighbors.allSatisfy { $0 > minimum }: .minimum
            case let maximum where neighbors.allSatisfy { $0 < maximum }: .maximum
            default: nil
            }
          } ())
          else { return nil }

          return (key: extremum, value: value)
        }
    )

    return (dictionary[.minimum] ?? [], dictionary[.maximum] ?? [])
  }

  /// Two minima, with the second satisfying a partitioning criterion.
  func minima(
    partitionedBy belongsInSecondPartition: (Element) -> Bool
  ) -> (Element?, Element?) {
    reduce(into: (nil, nil)) { minima, element in
      let partitionKeyPath = belongsInSecondPartition(element) ? \(Element?, Element?).1 : \.0

      if minima[keyPath: partitionKeyPath].map({ element < $0 }) ?? true {
        minima[keyPath: partitionKeyPath] = element
      }
    }
  }
}
private enum ExtremumOption { case minimum, maximum }

/// Create a "sorted tuple".
public func sort<Comparable: Swift.Comparable>(
  _ comparable0: Comparable, _ comparable1: Comparable
) -> (Comparable, Comparable) {
  comparable0 <= comparable1
    ? (comparable0, comparable1)
    : (comparable1, comparable0)
}
