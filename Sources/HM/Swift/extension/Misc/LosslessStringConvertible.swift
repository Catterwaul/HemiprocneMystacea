public extension LosslessStringConvertible
where Self: RawRepresentable, Self.RawValue: LosslessStringConvertible  {
  init?(_ description: String) {
    guard let rawValue = RawValue(description)
    else { return nil }

    self.init(rawValue: rawValue)
  }

  var description: String { .init(rawValue) }
}

public extension Dictionary where Key == String {
  init<Key: LosslessStringConvertible>(_ dictionary: [Key: Value]) {
    self = dictionary.mapKeys(\.description)
  }
}

public extension Dictionary where Key: LosslessStringConvertible {
  init(_ dictionary: [String: Value]) {
    self = dictionary.compactMapKeys(Key.init)
  }
}
