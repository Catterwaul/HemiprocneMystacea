public extension CaseIterable where Self: Equatable {
  static func ...(minimum: Self, maximum: Self) -> AllCases.SubSequence {
    let indices = [minimum, maximum].compactMap(allCases.firstIndex)
    return allCases[ indices[0]...indices[1] ]
  }

  /// The first match for this case in `allCases.indices`.
  /// - Throws: `AnyCaseIterable.AllCasesError.noIndex`
  func caseIndex() throws -> AllCases.Index {
    try Result(
      success: Self.allCases.firstIndex(of: self),
      failure: AnyCaseIterable.AllCasesError.noIndex(self)
    ).get()
  }
}

public extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
  /// The case after this one, in `Self.allCases`.
  /// - Parameter cyclic: Whether to wrap back around to the first case.
  /// - Returns: `nil` for the last case if  `cyclic` is `false`.
  func nextCase(cyclic: Bool = false) -> Self? {
    ( cyclic ? AnySequence(cycling: Self.allCases) : .init(Self.allCases) )
      .drop(while:) { $0 != self }
      .dropFirst()
      .first
  }
}

public enum AnyCaseIterable {
  public enum AllCasesError<Case>: Error {
    /// No `AllCases.Index` corresponds to this case.
    case noIndex(Case)
  }
}
