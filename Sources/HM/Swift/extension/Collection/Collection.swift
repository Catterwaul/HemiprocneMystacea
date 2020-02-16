public extension Collection {
  static func == <Equatable0: Equatable, Equatable1: Equatable>(
    tuples0: Self, tuples1: Self
  ) -> Bool
  where Element == (Equatable0, Equatable1) {
    guard tuples0.count == tuples1.count
    else { return false }

    return zip(tuples0, tuples1).allSatisfy(==)
  }

  static func == <
    Equatable0: Equatable, Equatable1: Equatable, Equatable2: Equatable
  >(tuples0: Self, tuples1: Self) -> Bool
  where Element == (Equatable0, Equatable1, Equatable2) {
    guard tuples0.count == tuples1.count
    else { return false }

    return zip(tuples0, tuples1).allSatisfy(==)
  }
}

public extension Collection where Element: Equatable {
  ///- Returns: nil if `element` isn't present
  func prefix(upTo element: Element) -> SubSequence? {
    firstIndex(of: element).map( prefix(upTo:) )
  }

  ///- Returns: nil if `element` isn't present
  func prefix(through element: Element) -> SubSequence? {
    firstIndex(of: element).map( prefix(through:) )
  }
  
  ///- Returns: nil if `element` isn't present
  func suffix(from element: Element) -> SubSequence? {
    firstIndex(of: element)
      .map { suffix( from: index(after: $0) ) }
  }
}

public extension Collection where SubSequence: RangeReplaceableCollection {
  func shifted(by shift: Int) -> SubSequence {
    let drops =
      shift > 0
      ? (shift, count - shift)
      : (count + shift, -shift)
    return dropFirst(drops.0) + dropLast(drops.1)
  }
}
