/// An affordance for adding extensions to every type.
@propertyWrapper public struct Wrapped<Value> {
  public var wrappedValue: Value
  public var projectedValue: Self { self }

  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}

public extension Wrapped {
  init(_ wrappedValue: Value) {
    self.init(wrappedValue: wrappedValue)
  }

  func callAsFunction(
    transform: (Value) throws -> Value
  ) rethrows -> Value {
    try transform(wrappedValue)
  }

  mutating func callAsFunction(
    transform: (inout Value) throws -> Void
  ) rethrows {
    try transform(&wrappedValue)
  }

  func `if`(
    _ condition: Bool,
    transform: (Value) throws -> Value
  ) rethrows -> Value {
    condition
      ? try transform(wrappedValue)
      : wrappedValue
  }
}

public extension Wrapped where Value: AnyObject {
  func callAsFunction(
    transform: (Value) throws -> Void
  ) rethrows {
    try transform(wrappedValue)
  }
}
