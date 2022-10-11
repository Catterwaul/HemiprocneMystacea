import struct OrderedCollections.OrderedDictionary

public extension Sequence {
  @inlinable func uniqued(
    on projection: (Element) throws -> some Hashable,
    uniquingWith combine: (Element, Element) throws -> Element
  ) rethrows -> [Element] {
    try OrderedDictionary(keyed(by: projection), uniquingKeysWith: combine)
      .values
      .elements
  }
}
