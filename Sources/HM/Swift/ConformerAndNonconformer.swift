/// A combination of an instance that conforms to protocols,
/// and one that is not required to.
/// The entire structure is considered to conform, if the conformer does.
public struct ConformerAndNonconformer<Conformer, Nonconformer> {
  public var conformer: Conformer
  public var nonconformer: Nonconformer
}

// MARK: - public
public extension ConformerAndNonconformer {
  init(_ conformer: Conformer, _ nonconformer: Nonconformer) {
    self.init(conformer: conformer, nonconformer: nonconformer)
  }
}

// MARK: - Equatable
extension ConformerAndNonconformer: Equatable where Conformer: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    forwardToConformers(lhs, ==, rhs)
  }
}

// MARK: - Comparable
extension ConformerAndNonconformer: Comparable where Conformer: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    forwardToConformers(lhs, <, rhs)
  }
}

// MARK: - Sendable
extension ConformerAndNonconformer: Sendable where Conformer: Sendable, Nonconformer: Sendable { }

// MARK: - private
private extension ConformerAndNonconformer {
  private static func forwardToConformers<Result>(
    _ self0: Self,
    _ requirement: (Conformer, Conformer) -> Result,
    _ self1: Self
  ) -> Result {
    requirement(self0.conformer, self1.conformer)
  }
}
