public func ~= <Value>(
  matchPattern: (Value) -> Bool,
  value: Value
) -> Bool {
  matchPattern(value)
}

public func ~= <Value>(
  keyPath: KeyPath<Value, Bool>,
  value: Value
) -> Bool {
  value[keyPath: keyPath]
}
