public protocol BackedByInteger
: ExpressibleByIntegerLiteral & Hashable & MutableCollection & RandomAccessCollection
where Index == Int {
  associatedtype Integer: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral
  
  init(_: Integer)
}

// MARK: - ExpressibleByIntegerLiteral
extension BackedByInteger {
  public init(integerLiteral integer: Integer) {
    self.init(integer)
  }
}

// MARK: - MutableCollection, RandomAccessCollection
extension BackedByInteger {
  public var startIndex: Index { 0 }
}
