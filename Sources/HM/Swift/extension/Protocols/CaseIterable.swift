public extension CaseIterable where Self: Equatable {
  static func ...(minimum: Self, maximum: Self) -> AllCases.SubSequence {
    let indices = [minimum, maximum].compactMap(allCases.firstIndex)
    return allCases[ indices[0]...indices[1] ]
  }

  /// The first match for this case in `allCases.indices`.
  /// - Throws: `AnyCaseIterable.AllCasesError.noIndex`
  func getCaseIndex() throws -> AllCases.Index {
    try Result(
      success: Self.allCases.firstIndex(of: self),
      failure: AnyCaseIterable.AllCasesError.noIndex(self)
    ).get()
  }
}

public enum AnyCaseIterable {
  public enum AllCasesError<Case>: Error {
    /// No `AllCases.Index` corresponds to this case.
    case noIndex(Case)
  }
}

public extension comparable where Self: CaseIterable {
  /// The index of two cases.
  var comparable: AllCases.Index { try! getCaseIndex() }
}
