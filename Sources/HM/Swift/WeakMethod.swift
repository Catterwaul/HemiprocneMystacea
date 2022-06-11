public struct WeakMethod<Reference: AnyObject, Input, Output> {
  public init(
    reference: Reference?,
    method: @escaping Method
  ) {
    self.reference = reference
    self.method = method
  }

  public weak var reference: Reference?
  public var method: Method
}

public extension WeakMethod {
  struct ReferenceDeallocatedError: Error { }

  typealias Method = (Reference) -> (Input) -> Output

  /// - Throws: ReferenceDeallocatedError
  func callAsFunction(_ input: Input) throws -> Output {
    guard let reference else { throw ReferenceDeallocatedError() }

    return method(reference)(input)
  }

// MARK:-
  init<Input0, Input1>(
    reference: Reference?,
    method: @escaping (Reference) -> (Input0, Input1) -> Output
  )
  where Input == (Input0, Input1) {
    self.reference = reference
    self.method = { reference in
      { method(reference)($0.0, $0.1) }
    }
  }

  /// - Throws: ReferenceDeallocatedError
  func callAsFunction<Input0, Input1>(_ input0: Input0, _ input1: Input1) throws -> Output
  where Input == (Input0, Input1) {
    try self((input0, input1))
  }
}

public extension WeakMethod where Input == () {
  init(
    reference: Reference?,
    method: @escaping (Reference) -> () -> Output
  ) {
    self.reference = reference
    self.method = { reference in
      { _ in method(reference)() }
    }
  }

  /// - Throws: ReferenceDeallocatedError
  func callAsFunction() throws -> Output {
    try self(())
  }
}
