/// An affordance for adding extensions to every type.
@propertyWrapper public struct Wrapped<Value> {
  public var wrappedValue: Value
  public var projectedValue: Self { self }

  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }

  public init(projectedValue: Self) {
    self = projectedValue
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

infix operator …

public func … <Value, Transformed>(
  value: Value,
  transform: (Value) -> Transformed
) -> Transformed {
  transform(value)
}

public func … <Value, Transformed>(
  value: Value,
  transform: (Value) throws -> Transformed
) throws -> Transformed {
  try transform(value)
}

/// A mutated version of a value.
public func … <Value>(
  value: Value,
  transform: (inout Value) -> Void
) -> Value {
  var value = value
  transform(&value)
  return value
}

public func … <Root, Value, Transformed>(
  value: @escaping (Root) -> Value,
  transform: @escaping (Value) -> Transformed
) -> (Root) -> Transformed {
  { transform(value($0)) }
}

public func … <Value, Transformed>(
  value: @escaping () -> Value,
  transform: @escaping (Value) -> Transformed
) -> () -> Transformed {
  { transform(value()) }
}
