import Algorithms
import OrderedCollections

public extension BidirectionalCollection where Self: MutableCollection & RangeReplaceableCollection {
  /// Adds the `set` accessor to the `last` property.
  var last_set: Element? {
    get { last }
    set {
      switch (isEmpty, newValue) {
      case (false, let newValue?): self[index(before: endIndex)] = newValue
      case (false, nil): removeLast()
      case (true, let newValue?): append(newValue)
      case (true, nil): break
      }
    }
  }
}

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
