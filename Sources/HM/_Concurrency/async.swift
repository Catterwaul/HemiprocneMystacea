/// Create an asynchronous version of a closure.
public func async<each Parameter, Value, Error>(
  _ sync: @escaping (repeat each Parameter) throws(Error) -> Value
) -> (repeat each Parameter) async throws(Error) -> Value  {
  sync
}
