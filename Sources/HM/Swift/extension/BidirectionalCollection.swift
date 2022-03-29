import Algorithms
import OrderedCollections

public extension BidirectionalCollection where Element: Equatable {
  /// A subsequence starting at the last occurrence of `element.`
  ///
  ///- Returns: nil if `element` isn't present.
  func suffix(from element: Element) -> SubSequence? {
    lastIndex(of: element).map(suffix)
  }
}

public extension BidirectionalCollection where Element: Hashable {
  var firstDuplicate: (index: Index, element: Element)? {
    var set: Set<Element> = []
    return indexed().reversed().reduce(into: nil) {
      if !set.insert($1.element).inserted {
        $0 = $1
      }
    }
  }
}
