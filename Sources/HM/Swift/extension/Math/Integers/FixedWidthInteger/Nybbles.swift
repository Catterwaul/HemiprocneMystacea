public extension FixedWidthInteger {
  init(_ nybbles: Nybbles<Self>) {
    self = nybbles.integer
  }

  var nybbles: Nybbles<Self> {
    get { .init(integer: self) }
    set { self = newValue.integer }
  }
}

/// The nybbles of an integer, from least significant to most.
public struct Nybbles<Integer: FixedWidthInteger>: Hashable {
  fileprivate var integer: Integer
}

// MARK: - MutableCollection
extension Nybbles: MutableCollection {
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

// MARK: - BidirectionalCollection
extension Nybbles: RandomAccessCollection {
  public func index(before index: Index) -> Index {
    index - 1
  }
}

// MARK: - RangeReplaceableCollection
extension Nybbles: RangeReplaceableCollection {
  /// All zeros.
  public init() {
    integer = 0
  }
}
