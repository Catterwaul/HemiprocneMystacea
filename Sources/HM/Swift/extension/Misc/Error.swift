/// A nondescript error.
public struct AnyError: Error & Equatable {
  public init() { }
}

extension Array: Error where Element: Error { }
extension Set: Error where Element: Error { }
