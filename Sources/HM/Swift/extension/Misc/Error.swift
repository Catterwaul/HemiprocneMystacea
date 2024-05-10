@available(
  swift, deprecated: 6,
  message: "Make this `static` within `Error`."
)
/// Coalesce throwing values.
/// - Note: The compiler cannot deal with an overload where `value1` does not `throw`.
///   **Workaround**: Use `try?` for those cases.
public func ?? <Value>(
  _ value0: @autoclosure () throws -> Value,
  _ value1: @autoclosure () throws -> Value
)  throws -> Value {
  do {
    return try value0()
  } catch {
    return try value1()
  }
}

@available(
  swift, deprecated: 6,
  message: "Make this `static` within `Error`."
)
/// Coalesce  throwing values.
/// - Note: The compiler cannot deal with another overload where `value1` is  not`async`.
///   **Workaround**: When the compile gains the ability to use sync overloads in an async context,
///   store the intermediate result and use the synchronous version of `??` on it.
public func ?? <Value>(
  _ value0: @autoclosure () async throws -> Value,
  _ value1: @autoclosure () async throws -> Value
) async throws -> Value {
  do {
    return try await value0()
  } catch {
    return try await value1()
  }
}

public extension Error {
  /// `throw` this from a function, instead of returning a value.
  func `throw`<Never>() throws -> Never {
    throw self
  }
}

@available(
  swift, deprecated: 6,
  message: "Nest this as `Error.Any`."
)
/// A nondescript error.
public struct AnyError: Error & Equatable {
  public init() { }
}

extension Array: Error where Element: Error { }
extension Set: Error where Element: Error { }
