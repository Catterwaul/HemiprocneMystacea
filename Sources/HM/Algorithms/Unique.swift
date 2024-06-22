import typealias OrderedCollections.OrderedDictionary

public extension Sequence {
  @inlinable func uniqued(
    on projection: (Element) throws -> some Hashable,
    uniquingWith combine: (Element, Element) throws -> Element
  ) rethrows -> [Element] {
    try OrderedDictionary(
      try map { (try projection($0), $0) },
      uniquingKeysWith: combine
    )
      .values
      .elements
  }
}
