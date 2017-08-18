public extension Collection where Element: Equatable {
  ///- Returns: nil if `element` isn't present
  func prefix(upTo element: Element) -> SubSequence? {
    return
      index(of: element)
      .map( prefix(upTo:) )
  }

  ///- Returns: nil if `element` isn't present
  func prefix(through element: Element) -> SubSequence? {
    return
      index(of: element)
      .map( prefix(through:) )
  }
  
  ///- Returns: nil if `element` isn't present
  func suffix(from element: Element) -> SubSequence? {
    return
      index(of: element)
      .map{suffix( from: index(after: $0) )}
  }
}
