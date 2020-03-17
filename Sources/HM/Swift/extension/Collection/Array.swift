public extension Array {
  init?<Subject>(mirrorChildValuesOf subject: Subject) {
    guard let array =
      Mirror(reflecting: subject).children.map(\.value)
      as? Self
    else { return nil }

    self = array
  }

  /// The first array will be shorter by one element,
  /// if `count` is odd.
  var splitInHalf: [Array] {
    let halfCount = count / 2
    return [
      prefix(upTo: halfCount),
      dropFirst(halfCount)
    ].map(Array.init)
  }
}
