public func getMemoryLayoutOffsets(_ attributes: (size: Int, alignment: Int)...) -> [Int] {
  guard !attributes.isEmpty
  else { return [] }
  
  return
    zip( attributes, attributes.dropFirst() + [ attributes[0] ] )
    .reduce(into: []) { offsets, attributes in
      let offset = (offsets.last ?? 0) + attributes.0.size
      
      offsets.append(
        offset
        + offset % attributes.1.alignment
      )
    }
}
