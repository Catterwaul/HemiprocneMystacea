public extension Array {
  /// The first array will be shorter by one element,
  /// if `count` is odd.
  var splitInHalf: [Array] {
    let halfCount = count / 2
    return [
      prefix(upTo: halfCount),
      dropFirst(halfCount)
    ].map(Array.init)
  }
}

public extension Array {
  struct OutOfBoundsError: Error {
    public let index: Index
  }
  
  /// - Returns: same as subscript, if index is in bounds
  /// - Throws: Array.OutOfBoundsError
  func getElement(index: Index) throws -> Element {
    guard indices.contains(index)
    else { throw OutOfBoundsError(index: index) }
    
    return self[index]
  }
}

public extension Array where Element: Hashable {
  var permutations: Permutations<Element> {
    return Permutations(self)
  }
}

public struct Permutations<Element>: Sequence, IteratorProtocol {
  private let array: [Element]
  private var permutation: [Element]!
  private var iteration = 0

  init(_ array: [Element]) {
    self.array = array
  }

  public mutating func next() -> [Element]? {
    guard iteration < array.count.factorial
    else { return nil }

    defer { iteration += 1 }

    var permutation = array
    for index in array.indices {
      let shift =
        iteration / (array.count - 1 - index).factorial
        % (array.count - index)
      permutation.replaceSubrange(
        index...,
        with: permutation.dropFirst(index).shifted(by: shift)
      )
    }
    return permutation
  }
}
