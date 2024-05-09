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

extension GetThrowsMutatingSet: ThrowingPropertyWrapper {
  
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
}
