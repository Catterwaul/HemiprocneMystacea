/// Adds reference semantics to a value type.
@propertyWrapper public final class Reference<Value> {
  public var wrappedValue: Value
  public var projectedValue: Reference { self }

  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}
