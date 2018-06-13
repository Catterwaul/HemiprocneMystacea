public protocol HashableClass: EquatableClass, Hashable {}

public extension HashableClass {
  var hashValue: Int {
    return ObjectIdentifier(self).hashValue
  }
}
