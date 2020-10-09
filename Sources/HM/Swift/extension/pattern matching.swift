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

/// Match non-`Equatable` `enum` cases without associated values.
public func ~= <Enum>(pattern: Enum, instance: Enum) -> Bool {
  guard let labels = (
    [pattern, instance].compactMap {
      Optional(Mirror(reflecting: $0))
        .filter {
          $0.displayStyle == .enum
            && $0.children.isEmpty
        }
    }
    .tuple2
  ) else { return false }

  return "\(labels.0)" == "\(labels.1)"
}
