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

public func `do`<Success, Failure>(
  _ result: Result<Success, Failure>,
  catch: (Failure) -> Void
) -> Success? {
  switch result {
  case .success(let success):
    return success
  case .failure(let failure):
    `catch`(failure)
    return nil
  }
}
