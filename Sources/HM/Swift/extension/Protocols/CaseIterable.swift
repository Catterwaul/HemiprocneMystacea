public extension CaseIterable where Self: Equatable {
  static func ...(minimum: Self, maximum: Self) -> AllCases.SubSequence {
    let indices = [minimum, maximum].compactMap(allCases.firstIndex)
    return allCases[ indices[0]...indices[1] ]
  }
}
