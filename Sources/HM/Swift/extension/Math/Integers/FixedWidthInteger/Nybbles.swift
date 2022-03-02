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

// MARK: - MutableCollection, RandomAccessCollection
extension Nybbles: MutableCollection, RandomAccessCollection {
  public typealias Index = Int

  public var startIndex: Index { 0 }
  public var endIndex: Index { Integer.bitWidth / 4 }

  public subscript(index: Index) -> Integer {
    get { integer >> (index * 4) & 0xF  }
    set {
      let index = index * 4
      integer &= ~(0xF << index)
      integer |= (newValue & 0xF) << index
    }
  }

  public func index(after index: Index) -> Index {
    index + 1
  }
}

// MARK: - RangeReplaceableCollection
extension Nybbles: RangeReplaceableCollection {
  /// All zeros.
  public init() {
    self.init(0)
  }
}

// MARK: BackedByInteger
extension Nybbles: BackedByInteger {
  // Automatic synthesis compiles but results in an infinite loop as of March 2022.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.integer == rhs.integer
  }

  public init(_ integer: Integer) {
    self.integer = integer
  }
}
