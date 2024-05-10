/// A workaround for limitations of Swift's computed properties.
///
/// Limitations of Swift's computed property accessors:
/// 1. They are not mutable.
/// 2. They cannot be referenced as closures.

/// - Note: Cannot use `@propertyWrapper` because
/// 1. "Property wrappers currently cannot define an 'async' or 'throws' accessor"
/// 2. "'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'"
public struct GetThrowsMutatingSet<Value, Error: Swift.Error> {
  public init(projectedValue: @escaping () throws -> Value) {
    self.projectedValue = projectedValue
  }

  public var projectedValue: () throws -> Value
}

// MARK: - public
public extension GetThrowsMutatingSet {
  init(wrappedValue: Value) {
    self.init { wrappedValue }
  }

  var wrappedValue: Value {
    get throws { try projectedValue() }
  }

  mutating func setWrappedValue(_ newValue: Value) {
    projectedValue = { newValue }
  }

  @available(
    swift, deprecated: 6,
    message: "Use typed throw instead of `as!`."
  )
  @inlinable func map<NewValue, NewError>(
    _ transformValue: @escaping (Value) throws -> NewValue,
    error transformError: @escaping (Error) -> NewError
  ) -> GetThrowsMutatingSet<NewValue, NewError> {
    .init {
      do {
        return try transformValue(wrappedValue)
      } catch {
        throw transformError(error as! Error)
      }
    }
  }

  @inlinable func map<NewValue>(
    _ transformValue: @escaping (Value) throws -> NewValue
  ) -> GetThrowsMutatingSet<NewValue, Error> {
    map(transformValue) { $0 }
  }

  @available(
    swift, deprecated: 6,
    message: "Use typed throw instead of `as!`."
  )
  @inlinable func map<NewError>(
    error transformError: @escaping (Error) -> NewError
  ) -> GetThrowsMutatingSet<Value, NewError> {
    map({ $0 }, error: transformError)
  }
}

@available(
  swift, deprecated: 6,
  message: "Use typed `throw`s."
)
public extension GetThrowsMutatingSet where Error == Swift.Error {
  init(projectedValue: @escaping () throws -> Value) {
    self.projectedValue = projectedValue
  }

  init(wrappedValue: Value) {
    self.init { wrappedValue }
  }
}

// MARK: - ThrowingPropertyWrapper
extension GetThrowsMutatingSet: ThrowingPropertyWrapper { }
