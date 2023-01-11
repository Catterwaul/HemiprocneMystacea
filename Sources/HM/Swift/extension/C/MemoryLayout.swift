import Algorithms

public func getMemoryLayoutOffsets(
  _ attributes: (size: Int, alignment: Int)...
) -> [Int] {
  chain(attributes, attributes.prefix(1))
    .adjacentPairs()
    .reductions(dropping: 0) { offset, attributes in
      let offset = offset + attributes.0.size
      return offset + offset % attributes.1.alignment
    }
}
