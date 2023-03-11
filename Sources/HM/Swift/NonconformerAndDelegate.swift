/// A combination of an instance that needs to conform to protocol, but doesn't,
/// and a "delegate", which does.
/// The entire structure is considered to conform, when the delegate does.
public struct NonconformerAndDelegate<Nonconformer, Delegate> {
  public var nonconformer: Nonconformer
  public var delegate: Delegate
}

// MARK: - public
public extension NonconformerAndDelegate {
  init(_ nonconformer: Nonconformer, delegate: Delegate) {
    self.init(nonconformer: nonconformer, delegate: delegate)
  }
}

// MARK: - Equatable
extension NonconformerAndDelegate: Equatable where Delegate: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    forwardToDelegates(lhs, ==, rhs)
  }
}

// MARK: - Comparable
extension NonconformerAndDelegate: Comparable where Delegate: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    forwardToDelegates(lhs, <, rhs)
  }
}

// MARK: - Sendable
extension NonconformerAndDelegate: Sendable where Nonconformer: Sendable, Delegate: Sendable { }

// MARK: - private
private extension NonconformerAndDelegate {
  private static func forwardToDelegates<Result>(
    _ self0: Self,
    _ requirement: (Delegate, Delegate) -> Result,
    _ self1: Self
  ) -> Result {
    requirement(self0.delegate, self1.delegate)
  }
}
