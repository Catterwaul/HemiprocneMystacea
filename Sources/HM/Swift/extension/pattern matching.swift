public func ~= <Value>(
  matchPattern: (Value) -> Bool,
  value: Value
) -> Bool {
  matchPattern(value)
}

//MARK:-

/// Match `enum` cases with associated values, while disregarding the values themselves.
/// - Parameter case: Looks like `Enum.case`.
public func ~= <Enum: Equatable, AssociatedValue>(
  case: (AssociatedValue) -> Enum,
  instance: Enum
) -> Bool {
  Mirror.associatedValue(of: instance, ifCase: `case`) != nil
}

/// Match `enum` cases with associated values, while disregarding the values themselves.
/// - Parameter case: Looks like `Enum.case`.
public func ~= <Enum, AssociatedValue>(
  case: (AssociatedValue) -> Enum,
  instance: Enum
) -> Bool {
  Mirror.associatedValue(of: instance, ifCase: `case`) != nil
}
