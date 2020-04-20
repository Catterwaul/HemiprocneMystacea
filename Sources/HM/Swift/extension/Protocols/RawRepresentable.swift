public extension RawRepresentable {
  static func contains(_ rawValue: RawValue) -> Bool {
    Self(rawValue: rawValue) != nil
  }
}

public extension LosslessStringConvertible
where Self: RawRepresentable, Self.RawValue: LosslessStringConvertible  {
  init?(_ description: String) {
    guard let rawValue = RawValue(description)
    else { return nil }

    self.init(rawValue: rawValue)
  }

  var description: String { .init(rawValue) }
}
