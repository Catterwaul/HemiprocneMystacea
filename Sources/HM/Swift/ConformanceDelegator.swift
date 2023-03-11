/// A combination of an instance that needs to conform to protocol, but doesn't,
/// and a "delegate", which does.
/// The entire structure is considered to conform, when the delegate does.
@propertyWrapper public struct ConformanceDelegator<Nonconformer, Delegate> {
  public var wrappedValue: Nonconformer
  public var delegate: Delegate

  public init(wrappedValue: Nonconformer, delegate: Delegate) {
    self.wrappedValue = wrappedValue
    self.delegate = delegate
  }

  public var projectedValue: Self {
    get { self }
    set { self = newValue }
  }
}

// MARK: - Equatable
extension ConformanceDelegator: Equatable where Delegate: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    forwardToDelegates(lhs, ==, rhs)
  }
}

// MARK: - Comparable
extension ConformanceDelegator: Comparable where Delegate: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    forwardToDelegates(lhs, <, rhs)
  }
}

// MARK: - Sendable
extension ConformanceDelegator: Sendable where Nonconformer: Sendable, Delegate: Sendable { }

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
