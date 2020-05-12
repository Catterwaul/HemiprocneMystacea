public extension RawRepresentable {
  static func contains(_ rawValue: RawValue) -> Bool {
    Self(rawValue: rawValue) != nil
  }

  /// Like `init(rawValue:)`, if it was throwing instead of failable.
  /// - Throws: `RawRepresentableError.invalidRawValue`
  /// if there is no value of the type that corresponds with the specified raw value.
  init(_ rawValue: RawValue) throws {
    guard let instance = Self(rawValue: rawValue)
    else { throw RawRepresentableError.invalidRawValue }

    self = instance
  }
}

enum RawRepresentableError: Error {
  case invalidRawValue
}

public extension InitializableWithElementSequence where Element: RawRepresentable {
  /// - Throws: `RawRepresentableError.invalidRawValue`
  init<RawValues: Sequence>(rawValues: RawValues) throws
  where RawValues.Element == Element.RawValue {
    self.init(
      try rawValues.map(Element.init)
    )
  }
}
