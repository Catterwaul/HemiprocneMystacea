infix operator ?!

/// Map one `Error` to another upon failure, disregarding the original.
public func ?! <Success>(
  _ success: () async throws -> Success,
  _ error: @autoclosure () -> some Error
) async throws -> Success {
  try await Result(catching: success)
    .mapError { _ in error() }
    .get()
}

/// A nondescript error.
public struct AnyError: Error & Equatable {
  public init() { }
}

public extension AnyError {
  /// Always `throw`, instead of returning a value.
  static func `throw`<Never>() throws -> Never {
    throw Self()
  }

  /// Always `throw`, instead of returning a value.
  static func `throw`<Never>() async throws -> Never {
    throw Self()
  }

  /// Initialize an `AnyError` if a closure throws an error.
  init?(_ value: () throws -> some Any) {
    do {
      _ = try value()
      return nil
    } catch {
      self.init()
    }
  }
}

extension Array: Error where Element: Error { }
extension Set: Error where Element: Error { }

public func `do`<Success>(
  _ success: () throws -> Success,
  catch: (any Error) -> Void
) -> Success? {
  do {
    return try success()
  } catch {
    `catch`(error)
    return nil
  }
}

public func `do`<Success>(
  _ success: () throws -> Success,
  catch: (any Error) -> Void
) throws -> Success {
  do {
    return try success()
  } catch {
    `catch`(error)
    throw error
  }
}
