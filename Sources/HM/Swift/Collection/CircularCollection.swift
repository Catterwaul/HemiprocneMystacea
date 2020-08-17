public struct CircularCollection<Collection: BidirectionalCollection> {
  public typealias Index = Collection.Index
  public typealias Element = Collection.Element

  public init(_ collection: Collection) {
    self.collection = collection
  }

  private let collection: Collection
}

// MARK: - Collection
extension CircularCollection: Swift.Collection {
  public subscript(index: Index) -> Element { collection[index] }

  public var endIndex: Index { collection.endIndex }

  public var startIndex: Index { collection.startIndex }

  public func index(after index: Index) -> Index {
    let index = collection.index(after: index)
    return index == endIndex ? startIndex : index
  }
}

// MARK: - BidirectionalCollection
extension CircularCollection: BidirectionalCollection {
  public func index(before index: Index) -> Index {
    index == startIndex
      ? self.index(endIndex, offsetBy: -1)
      : collection.index(before: index)
  }
}
