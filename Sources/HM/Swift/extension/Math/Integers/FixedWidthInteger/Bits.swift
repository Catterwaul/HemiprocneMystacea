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

// MARK: - MutableCollection, RandomAccessCollection
extension Bits: MutableCollection, RandomAccessCollection {
  public typealias Index = Int

  public var startIndex: Index { 0 }
  public var endIndex: Index { Integer.bitWidth }

  public subscript(index: Index) -> Integer {
    get { integer >> index & 1 }
    set {
      integer &= ~(1 << index)
      integer |= (newValue & 1) << index
    }
  }
}

// MARK: - RangeReplaceableCollection
extension Bits: RangeReplaceableCollection { }

// MARK: BackedByInteger
extension Bits: BackedByInteger {
  // Automatic synthesis compiles but results in an infinite loop as of March 2022.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.integer == rhs.integer
  }

  public init(_ integer: Integer) {
    self.integer = integer
  }
}
