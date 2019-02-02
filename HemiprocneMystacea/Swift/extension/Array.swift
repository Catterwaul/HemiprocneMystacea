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

public struct Permutations<Collection: Swift.Collection>: Sequence, IteratorProtocol {
  private let collection: Collection
  private var iteration = 0

  public init(_ collection: Collection) {
    self.collection = collection
  }

  public mutating func next() -> [Collection.Element]? {
    guard iteration < collection.count.factorial
    else { return nil }

    defer { iteration += 1 }

    var permutation = Array(collection)
    for index in 0..<collection.count {
      let shift =
        iteration / (collection.count - 1 - index).factorial
        % (collection.count - index)
      permutation.replaceSubrange(
        index...,
        with: permutation.dropFirst(index).shifted(by: shift)
      )
    }
    return permutation
  }
}
