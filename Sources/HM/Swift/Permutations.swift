public struct Permutations<Element> {
  public init<Sequence: Swift.Sequence>(_ sequence: Sequence)
  where Sequence.Element == Element {
    array = Array(sequence)
  }

  private let array: [Element]
}

//MARK: RandomAccessCollection
extension Permutations: RandomAccessCollection { }
public extension Permutations {
  subscript(position: Int) -> [Element] {
    array.indices.reduce(into: array) { permutation, index in
      let shift =
        position / (array.count - 1 - index).factorial!
        % (array.count - index)
      permutation.replaceSubrange(
        index...,
        with: permutation.dropFirst(index).shifted(by: shift)
      )
    }
  }

  var startIndex: Int { 0 }
  var endIndex: Int { array.count.factorial! }
}
