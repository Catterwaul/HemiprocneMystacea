public typealias ProcessGet<Gettable> = (() throws -> Gettable) -> Void

/// Used to eliminate the boilerplate of "processing throwing get accessors" returned from asynchronous functions.
/// Errors will be forwarded on; you won't need to use a `do/catch`.
/// Instead, you'll only provide a function to deal with successful access.
///
/// - Parameters:
///   - processGetError:
///       The function that would process the final get accessor in a chain of async calls.
///       You'll only use it here to forward errors, so it's not "processGetFinal".
///   - processIntermediate:
///       A function to deal with a successfully-accessed result.
///       It's *intermediate* because you'll either be making another async call,
///       or creating a get accessor for "processGetFinal" to use,
///       based on the result.
/// - Returns: a closure which handles both successes and failures.
public func makeProcess<Intermediate, Final>(
  processGetError: @escaping ProcessGet<Final>,
  _ processIntermediate: @escaping (Intermediate) throws -> Void
) -> ProcessGet<Intermediate> {
  { getIntermediate in
    do {
      try processIntermediate(getIntermediate())
    } catch {
      processGetError { throw error }
    }
  }
}
