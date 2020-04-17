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
