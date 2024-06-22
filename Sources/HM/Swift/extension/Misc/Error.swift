/// A nondescript error.
public struct AnyError: Error & Equatable {
  public init() { }
}

extension Array: @retroactive Error where Element: Error { }
extension Set: @retroactive Error where Element: Error { }
