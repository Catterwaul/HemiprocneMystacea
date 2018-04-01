public extension Array {
  struct OutOfBoundsError: Error {
    public let index: Index
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
  
  /// - Returns: same as subscript, if index is in bounds
  /// - Throws: Array.OutOfBoundsError
  func getElement(index: Index) throws -> Element {
    guard indices.contains(index)
    else {throw OutOfBoundsError(index: index)}
    
    return self[index]
  }
}
