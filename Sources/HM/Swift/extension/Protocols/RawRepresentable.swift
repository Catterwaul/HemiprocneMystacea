public extension RawRepresentable {
  static func contains(_ rawValue: RawValue) -> Bool {
    Self(rawValue: rawValue) != nil
  }

  /// Like `init(rawValue:)`, if it was throwing instead of failable.
  /// - Throws: `RawRepresentableExtensions<Self>.Error.invalidRawValue`
  /// if there is no value of the type that corresponds with the specified raw value.
  init(_ rawValue: RawValue) throws {
    do { self = try Self(rawValue: rawValue).unwrapped }
    catch { throw ConcreteRawRepresentable<Self>.Error.invalidRawValue(rawValue) }
  }
}

/// A namespace for nested types within `RawRepresentable`.
public enum ConcreteRawRepresentable<RawRepresentable: Swift.RawRepresentable>  {
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
