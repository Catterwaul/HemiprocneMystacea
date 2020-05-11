public func ~= <Value>(
  matchPattern: (Value) -> Bool,
  value: Value
) -> Bool {
  matchPattern(value)
}

/// Match `enum` cases with associated values, while disregarding the values themselves.
/// - Parameter makeCase: Looks like `Enum.case`.
public func ~= <Enum: Equatable, AssociatedValue>(
  makeCase: (AssociatedValue) -> Enum,
  instance: Enum
) -> Bool {
  Mirror(reflecting: instance).getAssociatedValue().map(makeCase)
  == instance
}
