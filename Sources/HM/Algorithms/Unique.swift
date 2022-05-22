import struct OrderedCollections.OrderedDictionary

public extension Sequence {
  @inlinable func uniqued<Subject: Hashable>(
    on projection: (Element) throws -> Subject,
    uniquingWith combine: (Element, Element) throws -> Element
  ) rethrows -> [Element] {
    try OrderedDictionary(keyed(by: projection), uniquingKeysWith: combine)
      .values
      .elements
  }
}
