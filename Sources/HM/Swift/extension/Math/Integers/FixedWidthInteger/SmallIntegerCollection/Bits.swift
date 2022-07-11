public extension FixedWidthInteger where Self: _ExpressibleByBuiltinIntegerLiteral {
  var bits: Bits<Self> {
    get { .init(self) }
    set { self = newValue.container }
  }
}

/// The bits of an integer, from least significant to most.
public struct Bits<Container: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral> {
  public var container: Container
}

// MARK: - SmallIntegerCollection
extension Bits: SmallIntegerCollection {
  public static var elementBitWidth: Int { 1 }

  public init(_ integer: Container) {
    self.container = integer
  }
}
