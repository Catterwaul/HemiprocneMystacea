public extension BinaryInteger {
  /// The bits of an integer, from least significant to most.
  var bits: SmallIntegerCollection<Self> {
    get { .init(container: self, elementBitWidth: 1) }
    set { self = newValue.container }
  }

  /// The nybbles of an integer, from least significant to most.
  var nybbles: SmallIntegerCollection<Self> {
    get { .init(container: self, elementBitWidth: 4) }
    set { self = newValue.container }
  }
}

/// A collection of integers which "fit" into a larger integer type.
///
/// `Container` is an integer that can contain `Container.bitWidth / elementBitWidth` elements.
/// `SmallIntegerCollection` divides it evenly; indexing is performed from least significant divisions to most.
public struct SmallIntegerCollection<Container: BinaryInteger> {
  public init(container: Container, elementBitWidth: Int) {
    self.container = container
    self.elementBitWidth = elementBitWidth
  }

  /// The backing storage unit for this collection.
  public var container: Container

  /// The number of bits needed for the underlying binary representation of each element of this collection.
  public var elementBitWidth: Int
}

// MARK: - public
public extension SmallIntegerCollection {
  /// An element with `1` for all bits.
  var mask: Container { ~(~0 << elementBitWidth) }
}

// MARK: - MutableCollection & RandomAccessCollection
extension SmallIntegerCollection: MutableCollection & RandomAccessCollection {
  public typealias Index = Int

  public var startIndex: Index { 0 }
  public var endIndex: Index { Container().bitWidth / elementBitWidth }

  public subscript(index: Index) -> Container {
    get { container >> (index * elementBitWidth) & mask }
    set {
      let index = index * elementBitWidth
      container &= ~(mask << index)
      container |= (newValue & mask) << index
    }
  }
}
