public func ~= <Value>(
  matchPattern: (Value) -> Bool,
  value: Value
) -> Bool {
  matchPattern(value)
}

//MARK:-

/// Match `enum` cases with associated values, while disregarding the values themselves.
/// - Parameter makeCase: Looks like `Enum.case`.
public func ~= <Enum: Equatable, AssociatedValue>(
  makeCase: (AssociatedValue) -> Enum,
  instance: Enum
) -> Bool {
  Mirror(reflecting: instance).getAssociatedValue().map(makeCase)
  == instance
}

/// Match `enum` cases with associated values, while disregarding the values themselves.
/// - Parameter makeCase: Looks like `Enum.case`.
public func ~= <Enum, AssociatedValue>(
  makeCase: (AssociatedValue) -> Enum,
  instance: Enum
) -> Bool {
  let instanceMirror = Mirror(reflecting: instance)

  guard let dummyCase = instanceMirror.getAssociatedValue().map(makeCase)
  else { return false }

  return
    Mirror(reflecting: dummyCase).children.first?.label
    == instanceMirror.children.first?.label
}
