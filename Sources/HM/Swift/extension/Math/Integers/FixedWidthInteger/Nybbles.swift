public extension FixedWidthInteger where Self: _ExpressibleByBuiltinIntegerLiteral {
  var nybbles: Nybbles<Self> {
    get { .init(self) }
    set { self = newValue.integer }
  }
}

/// The nybbles of an integer, from least significant to most.
public struct Nybbles<Integer: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral> {
  public var integer: Integer
}

// MARK: - Collection
extension Nybbles {
  public var endIndex: Index { Integer.bitWidth / 4 }

  public subscript(index: Int) -> Integer {
    get { integer >> (index * 4) & 0xF }
    set {
      let index = index * 4
      integer &= ~(0xF << index)
      integer |= (newValue & 0xF) << index
    }
  }
}

// MARK: - BackedByInteger
extension Nybbles: BackedByInteger {
  public init(_ integer: Integer) {
    self.integer = integer
  }
}
