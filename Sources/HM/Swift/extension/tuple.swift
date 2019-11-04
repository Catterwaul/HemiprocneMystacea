public typealias TuplePlaceholder = Void

public func == <
  Tuples: Collection,
  Equatable0: Equatable, Equatable1: Equatable
>(tuples0: Tuples, tuples1: Tuples) -> Bool
where Tuples.Element == (Equatable0, Equatable1) {
  guard tuples0.count == tuples1.count
  else { return false }

  return zip(tuples0, tuples1).allSatisfy(==)
}

public func == <
  Tuples: Collection,
  Equatable0: Equatable, Equatable1: Equatable, Equatable2: Equatable
>(tuples0: Tuples, tuples1: Tuples) -> Bool
where Tuples.Element == (Equatable0, Equatable1, Equatable2) {
  guard tuples0.count == tuples1.count
  else { return false }

  return zip(tuples0, tuples1).allSatisfy(==)
}
