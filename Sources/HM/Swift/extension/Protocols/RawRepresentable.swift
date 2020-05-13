public extension RawRepresentable {
  static func contains(_ rawValue: RawValue) -> Bool {
    Self(rawValue: rawValue) != nil
  }

  /// Like `init(rawValue:)`, if it was throwing instead of failable.
  /// - Throws: `RawRepresentableExtensions<Self>.Error.invalidRawValue`
  /// if there is no value of the type that corresponds with the specified raw value.
  init(_ rawValue: RawValue) throws {
    guard let instance = Self(rawValue: rawValue)
    else { throw RawRepresentableExtensions<Self>.Error.invalidRawValue(rawValue) }

    self = instance
  }
}

/// A namespace for nested types within `RawRepresentable`.
public enum RawRepresentableExtensions<RawRepresentable: Swift.RawRepresentable> {
  public enum Error: Swift.Error {
    case invalidRawValue(RawRepresentable.RawValue)
  }
}

public extension InitializableWithElementSequence where Element: RawRepresentable {
  /// - Throws: `RawRepresentableExtensions<Element>.Error.invalidRawValue`
  init<RawValues: Sequence>(rawValues: RawValues) throws
  where RawValues.Element == Element.RawValue {
    self.init(
      try rawValues.map(Element.init)
    )
  }
}
