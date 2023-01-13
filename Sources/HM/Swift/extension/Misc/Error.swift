/// A nondescript error.
public struct AnyError: Error & Equatable {
  public init() { }
}

public extension AnyError {
  /// Always `throw`, instead of returning a value.
  static func `throw`<Never>() throws -> Never {
    throw AnyError()
  }

  /// Initialize an `AnyError` if a closure throws an error.
  init?<Value>(_ value: () throws -> Value) {
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
