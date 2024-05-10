/// Create an asynchronous version of a closure.
public func async<Value>(
  _ sync: @escaping () throws -> Value
) -> () async throws -> Value  {
  sync
}

/// Create an asynchronous version of a closure.
public func async<Parameters, Value>(
  _ sync: @escaping (Parameters) throws -> Value
) -> (Parameters) async throws -> Value  {
  sync
}
