public extension Comparable {
  /// The properties with the maximum value.
  /// - Parameter subject: An instance of any type.
  /// - Returns: `nil` if no value matches the `Comparable` type.
  static func max<Subject>(
    ofPropertiesOf subject: Subject
  ) -> (labels: [String], value: Self)? {
    max(ofPropertiesOf: subject, by: <)
  }

  /// The properties with the maximum value.
  /// - Parameters:
  ///   - subject: An instance of any type.
  ///   - getAreInIncreasingOrder: Sorts two values.
  /// - Returns: `nil` if no value matches the `Comparable` type.
  static func max<Subject>(
    ofPropertiesOf subject: Subject,
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
    min( Swift.max(limits.lowerBound, self), limits.upperBound )
  }
}

public extension Sequence where Element: Comparable {
  var localExtrema: (minima: [Element], maxima: [Element]) {
    let dictionary = Dictionary<Extremum, [Element]>(grouping:
      removingDuplicates.consecutiveElements(by: 3).compactMap { consecutiveElements in
        let value = consecutiveElements[1]
        
        guard let extremum: Extremum = ( {
          let neighbors = [0, 2].map { consecutiveElements[$0] }
          switch value {
          case let minimum where neighbors.allSatisfy { $0 > minimum }:
            return .minimum
          case let maximum where neighbors.allSatisfy { $0 < maximum }:
            return .maximum
          default:
            return nil
          }
        } () )
        else { return nil }

        return (key: extremum, value: value)
      }
    )

    return (dictionary[.minimum] ?? [], dictionary[.maximum]  ?? [])
  }
}
private enum Extremum { case minimum, maximum }

//MARK:- comparable

/// A type with a `comparable` property, used for `<`.
public protocol comparable: Comparable {
  associatedtype Comparable: Swift.Comparable
  var comparable: Comparable { get }
}

public extension comparable {
  static func < (comparable0: Self, comparable1: Self) -> Bool {
    comparable0.comparable < comparable1.comparable
  }
}
