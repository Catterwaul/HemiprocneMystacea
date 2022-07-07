public extension FixedWidthInteger where Self: _ExpressibleByBuiltinIntegerLiteral {
  var bits: Bits<Self> {
    get { .init(self) }
    set { self = newValue.integer }
  }
}

/// The bits of an integer, from least significant to most.
public struct Bits<Integer: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral> {
  public var integer: Integer
}

// MARK: - Collection
extension Bits: BackedByInteger {
  public var endIndex: Index { Integer.bitWidth }

  public subscript(index: Int) -> Integer {
    get { integer >> index & 1 }
    set {
      integer &= ~(1 << index)
      integer |= (newValue & 1) << index
    }
  }
}

// MARK: - BackedByInteger
extension Bits {
  public init(_ integer: Integer) {
    self.integer = integer
  }
}
