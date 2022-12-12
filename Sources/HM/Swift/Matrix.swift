/// A rectangular matrix.
public struct Matrix<Element> {
  public var columns: [[Element]]
}

public extension Matrix {
  typealias Index = SIMD2<Int>

  init(columns: some Sequence<some Sequence<Element>>) {
    self.columns = columns.map(Array.init)
  }

  init(rows: some Sequence<some Sequence<Element>>) {
    self.init(columns: rows.transposed)
  }

  /// Ensure an index is valid before accessing an element of the collection.
  /// - Returns: The same as the unlabeled subscript, if an error is not thrown.
  /// - Throws: `AnyCollection<Element>.IndexingError`
  ///   if `indices` does not contain `index`.
  subscript(validating index: Index) -> Element {
    get throws {
      try columns[validating: index.x][validating: index.y]
    }
  }

  var rows: [[Element]] {
    get { columns.transposed.map(Array.init) }
    set { columns = newValue.transposed.map(Array.init) }
  }

  var indices: some Sequence<Index> {
    rows.indexed().lazy.flatMap { row in
      row.element.indices.lazy.map { .init($0, row.index) }
    }
  }

  /// Indexed neighbors in four directions.
  /// - Note: There will be fewer than 4 if the index is on an edge.
  func orthogonalNeighbors(_ index: Index) -> [Index: Element] {
    .init(
      uniqueKeysWithValues:
        [Index(-1, 0), .init(1, 0), .init(0, 1), .init(0, -1)].lazy.compactMap { offset in
          let index = index &+ offset
          return (try? self[validating: index]).map { (index, $0) }
        }
    )
  }

  /// - Throws: `AnyCollection<Element>.IndexingError()`
  /// if the index is not contained within the matrix's indices.
  func validate(_ index: Index) throws  {
    _ = try self[validating: index]
  }
}
