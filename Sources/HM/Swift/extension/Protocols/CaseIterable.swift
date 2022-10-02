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

extension IteratorProtocol where Self: CaseIterable & Equatable {
  /// The case after this one, in `Self.allCases`.
  public func next() -> Self? {
    .allCases[after: self]
  }

  /// The case after this one, in `Self.allCases.cycled()`.
  public func next() -> Self {
    .allCases.cycled()[after: self]!
  }
}

public enum AllCasesError<Case: CaseIterable>: Error {
  /// No `AllCases.Index` corresponds to this case.
  case noIndex(Case)
}
