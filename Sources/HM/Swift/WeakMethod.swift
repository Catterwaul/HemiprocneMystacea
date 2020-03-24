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
    guard let reference = reference
      else { throw ReferenceDeallocatedError() }

    return method(reference)(input)
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
    try self( () )
  }
}
