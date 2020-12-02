public func ~= <Value>(
  matchPattern: (Value) -> Bool,
  value: Value
) -> Bool {
  matchPattern(value)
}

// MARK: -

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

/// Match non-`Equatable` `enum` cases without associated values.
public func ~= <Enum>(pattern: Enum, instance: Enum) -> Bool {
  guard (
    [pattern, instance].allSatisfy {
      let mirror = Mirror(reflecting: $0)
      return
        mirror.displayStyle == .enum
        && mirror.children.isEmpty
    }
  ) else { return false }

  return .equate(pattern, to: instance) { "\($0)" }
}
