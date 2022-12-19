/// Mutate an enum instance's payload.
/// - Parameter associatedValue: It can't actually be a key path because they can't throw.
///   But it will look close, like `{ try $0.case }`
///   That requires an instance property, `case`,
///   which needs to be manually defined because you can't actually
///   check the case and get at the payload in any simpler way.
/// - Parameter case: The `case` of the enum, as a method.
public func set<Enum, AssociatedValue>(
  _ instance: inout Enum,
  _ associatedValue: (Enum) throws -> AssociatedValue,
  _ transform: (AssociatedValue) throws -> AssociatedValue,
  _ case: (AssociatedValue) -> Enum
) throws {
  instance = try `case`(transform(associatedValue(instance)))
}

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
