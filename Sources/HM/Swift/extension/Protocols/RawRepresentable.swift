public extension RawRepresentable {
  static func contains(_ rawValue: RawValue) -> Bool {
    Self(rawValue: rawValue) != nil
  }
}
