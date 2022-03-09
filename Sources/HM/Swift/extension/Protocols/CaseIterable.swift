public extension CaseIterable where Self: Equatable {
  static func ...(minimum: Self, maximum: Self) -> AllCases.SubSequence {
    let indices = [minimum, maximum].compactMap(allCases.firstIndex)
    return allCases[indices[0]...indices[1]]
  }

  /// The first match for this case in `allCases`.
  /// - Throws: `AllCasesError<Self>.noIndex`
  var caseIndex: AllCases.Index {
    get throws {
      do { return try Self.allCases.firstIndex(of: self).unwrapped }
      catch { throw AllCasesError.noIndex(self) }
    }
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

public enum AllCasesError<Case: CaseIterable>: Error {
  /// No `AllCases.Index` corresponds to this case.
  case noIndex(Case)
}
