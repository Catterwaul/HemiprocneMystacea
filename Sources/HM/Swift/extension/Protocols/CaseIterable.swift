public extension CaseIterable where Self: Equatable {
  /// The index of  a case, in `allCases`.
  static subscript(_ case: Self) -> AllCases.Index {
    allCases.firstIndex(of: `case`)!
  }

  static func ...(minimum: Self, maximum: Self) -> AllCases.SubSequence {
    let indices = [minimum, maximum].compactMap(allCases.firstIndex)
    return allCases[ indices[0]...indices[1] ]
  }

  func offset(by offset: Int) -> Self {
    Self.allCases[self, moduloOffset: offset]!
  }
}

public protocol CaseSequence:
  CaseIterable, Sequence, IteratorProtocol, Equatable
{ }

public extension CaseSequence {
  mutating func next() -> Self? {
    self = offset(by: 1)
    return self
  }
}
