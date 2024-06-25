/// A nondescript error.
public struct AnyError: Error & Equatable {
  public init() { }
}

extension Array: @retroactive Error where Element: Error { }
extension Set: @retroactive Error where Element: Error { }

/// A mechanism to interface between untyped and typed errors.
/// - Parameters:
///   - _:  This should be unnecessary, but it's not. And the default seems unusable as well.
///   - value: This should be an autoclosure but that can't compile.
func forceCastError<Value, Error>(
  _: Error.Type = Error.self,
  _ value: () throws -> Value
) throws(Error) -> Value {
  do {
    return try value()
  } catch {
    throw error as! Error
  }
}
