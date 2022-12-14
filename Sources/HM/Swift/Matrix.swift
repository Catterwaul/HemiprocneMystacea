import Algorithms
import HeapModule

/// A rectangular matrix.
public struct Matrix<Element> {
  public var columns: [[Element]]
}

public extension Matrix {
  typealias Index = SIMD2<Int>

  struct IndexingError: Error {
    public init() { }
  }

  init(columns: some Sequence<some Sequence<Element>>) {
    self.columns = columns.map(Array.init)
  }

  init(rows: some Sequence<some Sequence<Element>>) {
    self.init(columns: rows.transposed)
  }

  subscript(index: Index) -> Element {
    get { columns[index.x][index.y] }
    set { columns[index.x][index.y] = newValue }
  }

  /// Ensure an index is valid before accessing an element of the collection.
  /// - Returns: The same as the unlabeled subscript, if an error is not thrown.
  /// - Throws: `AnyCollection<Element>.IndexingError`
  ///   if `indices` does not contain `index`.
  subscript(validating index: Index) -> Element {
    get throws {
      do {
        return try columns[validating: index.x][validating: index.y]
      } catch {
        throw IndexingError()
      }
    }
  }

  var size: Index { [columns.count, columns.first?.count ?? 0]}

  var rows: [[Element]] {
    get { columns.transposed.map(Array.init) }
    set { columns = newValue.transposed.map(Array.init) }
  }

  var indices: some Sequence<Index> {
    product(0..<size.y, 0..<size.x).lazy.map { y, x in
      .init(x, y)
    }
  }

  var indexed: some Sequence<(index: Index, element: Element)> {
    indices.lazy.map { ($0, columns[$0.x][$0.y]) }
  }

  /// Draw a picture! 🧑‍🎨
  func description(_ transform: (Element) -> String) -> String {
    rows.map { $0.lazy.map(transform).joined() }
      .joined(separator: "\n")
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

  /// A dictionary that can be walked backwards, to achieve to shortest path to `start`.
  /// - Parameter connected: Whether two orthogonal neighbors are considered to be connected. Order matters.
  func shortestPathSources(
    from start: Index,
    connected: (_ source: Element, _ destination: Element) -> Bool
  ) -> [Index: Index] {
    var shortestPathSources: [Index: Index] = [:]
    var stepCounts = [start: 0]
    func stepCount(index: Index) -> Int { stepCounts[index]! }
    var heap = Heap([Heap.ElementValuePair(start, stepCount)])

    while let source = heap.popMin()?.value {
      let newStepCount = stepCounts[source]! + 1

      for destination in orthogonalNeighbors(source)
      where
        connected(try! self[validating: source], destination.value)
        && stepCounts[destination.key].map({ newStepCount < $0 }) != false
      {
        stepCounts[destination.key] = newStepCount
        shortestPathSources[destination.key] = source
        heap.insert(.init(destination.key, stepCount))
      }
    }

    return shortestPathSources
  }

  /// - Throws: `AnyCollection<Element>.IndexingError()`
  /// if the index is not contained within the matrix's indices.
  func validate(_ index: Index) throws  {
    _ = try self[validating: index]
  }
}

extension Matrix: Sequence {
  public func makeIterator() -> some IteratorProtocol<Element> {
    indexed.lazy.map(\.element).makeIterator()
  }
}
