/// A collection of integers which "fit" into a larger integer type, with evenly-divided storage.
public protocol SmallIntegerCollection:
  ExpressibleByIntegerLiteral, Hashable,
  MutableCollection, RandomAccessCollection
where Index == Int {
  /// An integer that can contain `Container.bitWidth / Self.elementBitWidth` elements.
  associatedtype Container: FixedWidthInteger, ExpressibleByIntegerLiteral
  
  /// The number of bits needed for the underlying binary representation of elements of this collection.
  static var elementBitWidth: Int { get }

  init(_: Container)

  /// The backing storage unit for this collection.
  var container: Container { get set }
}

// MARK: - public
public extension SmallIntegerCollection {
  /// An element with `1` for all bits.
  static var mask: Container { ~(~0 << Self.elementBitWidth) }
}


// MARK: - ExpressibleByIntegerLiteral
public extension SmallIntegerCollection {
  // MARK:
  init(integerLiteral integer: Container) {
    self.init(integer)
  }
}

// MARK: - MutableCollection, RandomAccessCollection
extension SmallIntegerCollection {
  public var startIndex: Index { 0 }
  public var endIndex: Index { Container.bitWidth / Self.elementBitWidth }

  public subscript(index: Int) -> Container {
    get { container >> (index * Self.elementBitWidth) & Self.mask }
    set {
      let index = index * Self.elementBitWidth
      container &= ~(Self.mask << index)
      container |= (newValue & Self.mask) << index
    }
  }
}
