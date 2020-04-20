public extension CaseIterable where Self: Equatable {
  /// The index of  a case, in `allCases`.
  static subscript(_ case: Self) -> AllCases.Index {
    allCases.firstIndex(of: `case`)!
  }

  static func ...(minimum: Self, maximum: Self) -> AllCases.SubSequence {
    let indices = [minimum, maximum].compactMap(allCases.firstIndex)
    return allCases[ indices[0]...indices[1] ]
  }
}
