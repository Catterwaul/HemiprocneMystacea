/// An instance that needs to conform to protocol, but doesn't,
/// which delegates to an instance of something that does conform.
/// The entire type is considered to conform, when the delegate does.
public protocol ConformanceDelegator {
  associatedtype Delegate
  var delegate: Delegate { get }
}

// MARK: - Comparable
extension ConformanceDelegator where Delegate: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    forwardToDelegates(lhs, <, rhs)
  }
}

// MARK: - Equatable
extension ConformanceDelegator where Delegate: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    forwardToDelegates(lhs, ==, rhs)
  }
}

// MARK: - private
private extension ConformanceDelegator {
  private static func forwardToDelegates<Result>(
    _ self0: Self,
    _ requirement: (Delegate, Delegate) -> Result,
    _ self1: Self
  ) -> Result {
    requirement(self0.delegate, self1.delegate)
  }
}
