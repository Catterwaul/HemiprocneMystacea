public struct Permutations<Sequence: Swift.Sequence>: Swift.Sequence, IteratorProtocol {
  public typealias Array = [Sequence.Element]

  private let array: Array
  private var iteration = 0

  public init(_ sequence: Sequence) {
    array = Array(sequence)
  }

  public mutating func next() -> Array? {
    guard iteration < array.count.factorial
    else { return nil }

    defer { iteration += 1 }

    var permutation = array
    for index in array.indices {
      permutation.replaceSubrange(
        index...,
        with:
          permutation.dropFirst(index)
          .shifted(
            by:
              iteration / (array.count - 1 - index).factorial
              % (array.count - index)
          )
      )
    }
    return permutation
  }
}
