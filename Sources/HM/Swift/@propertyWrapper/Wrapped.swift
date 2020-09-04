/// An affordance for adding extensions to every type.
@propertyWrapper public struct Wrapped<Value> {
  public let wrappedValue: Value
  public var projectedValue: Self { self }

  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}

public extension Wrapped {
  typealias Transform = (Value) throws -> Value

  func callAsFunction(transform: Transform) rethrows -> Value {
    try transform(wrappedValue)
  }

  func `if`(_ condition: Bool, transform: Transform) rethrows -> Value {
    condition
      ? try transform(wrappedValue)
      : wrappedValue
  }
}
