public protocol HashableClass: EquatableClass, Hashable { }

public extension HashableClass {
  func hash(into hasher: inout Hasher) {
    hasher.combine( ObjectIdentifier(self) )
  }
}
