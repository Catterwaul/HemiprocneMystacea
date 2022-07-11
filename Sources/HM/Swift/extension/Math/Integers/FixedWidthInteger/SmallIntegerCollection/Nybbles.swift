public extension FixedWidthInteger where Self: _ExpressibleByBuiltinIntegerLiteral {
  var nybbles: Nybbles<Self> {
    get { .init(self) }
    set { self = newValue.container }
  }
}

/// The nybbles of an integer, from least significant to most.
public struct Nybbles<Container: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral> {
  public var container: Container
}

// MARK: - SmallIntegerCollection
extension Nybbles: SmallIntegerCollection {
  public static var elementBitWidth: Int { 4 }

  public init(_ integer: Container) {
    self.container = integer
  }
}
