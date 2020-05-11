public extension Mirror {
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
