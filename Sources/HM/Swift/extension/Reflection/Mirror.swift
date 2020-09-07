public extension Mirror {
  /// Recursively searches first `Children` for a value of matching type.
  static func peel<Value>(_ subject: Any) -> Value? {
    Mirror(reflecting: subject).children.first.flatMap {
      $0.value as? Value
        ?? peel($0.value)
    }
  }

  var reflectsOptionalNone: Bool {
    switch displayStyle {
    case .optional?:
      return children.isEmpty
    default:
      return false
    }
  }

  /// Get an `enum` case's `associatedValue`.
  static func associatedValue<AssociatedValue>(
    of subject: Any,
    _: AssociatedValue.Type = AssociatedValue.self
  ) -> AssociatedValue? {
    guard let childValue = Self(reflecting: subject).children.first?.value
    else { return nil }

    if let associatedValue = childValue as? AssociatedValue {
      return associatedValue
    }

    let labeledAssociatedValue = Self(reflecting: childValue).children.first
    return labeledAssociatedValue?.value as? AssociatedValue
  }

  /// Get an `enum` case's `associatedValue`.
  /// - Parameter case: Looks like `Enum.case`.
  static func associatedValue<Enum: Equatable, AssociatedValue>(
    of instance: Enum,
    ifCase case: (AssociatedValue) -> Enum
  ) -> AssociatedValue? {
    associatedValue(of: instance).filter { `case`($0) == instance }
  }

  /// Get an `enum` case's `associatedValue`.
  /// - Parameter case: Looks like `Enum.case`.
  static func associatedValue<Enum, AssociatedValue>(
    of instance: Enum,
    ifCase case: (AssociatedValue) -> Enum
  ) -> AssociatedValue? {
    associatedValue(of: instance).filter {
      func label(_ subject: Any) -> String? {
        Self(reflecting: subject).children.first?.label
      }

      return label(`case`($0)) == label(instance)
    }
  }
}
