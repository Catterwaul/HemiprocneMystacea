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
