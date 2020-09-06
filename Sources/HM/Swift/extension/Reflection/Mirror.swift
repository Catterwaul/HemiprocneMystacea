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

  /// Get the associated value from an `enum` instance.
  func getAssociatedValue<AssociatedValue>(
    _: AssociatedValue.Type = AssociatedValue.self
  ) -> AssociatedValue? {
    guard let childValue = children.first?.value
    else { return nil }

    if let associatedValue = childValue as? AssociatedValue {
      return associatedValue
    }

    let labeledAssociatedValue = Mirror(reflecting: childValue).children.first
    return labeledAssociatedValue?.value as? AssociatedValue
  }
}
