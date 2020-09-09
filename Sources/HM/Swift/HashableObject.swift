public protocol HashableObject: EquatableObject, Hashable { }

public extension HashableObject {
  func hash(into hasher: inout Hasher) {
    hasher.combine( ObjectIdentifier(self) )
  }
}
