/// When you want `Array` to act more like a superclass,
/// use this!
public protocol BackedByArray: Collection {
  // This seems pointless to me
  // but I can't get the compiler warnings to shut up without using it.
  associatedtype BackingArrayElement: Equatable where BackingArrayElement == Element
  
  static func + <Elements: Sequence>(_: Self, _: Elements) -> Self
  where Elements.Element == Element
  
  static func - (_: Self, _: Element) -> Self
  
  /// Don't actually use this directly.
  /// It's only public because protocols
  /// don't have good enough access control yet.
  var backingArray: [Element] {get}
}

//MARK: public
public extension BackedByArray {
  static func += (
    backedByArray: inout Self,
    array: [Element]
  ) {
    backedByArray = backedByArray + array
  }
  
  static func -= (
    backedByArray: inout Self,
    element: Element
  ) {
    backedByArray = backedByArray - element
  }
  
  static func == <Elements: Sequence>(
    backedByArray: Self,
    elements: Elements
  ) -> Bool
  where Elements.Element == Element {
    return backedByArray.backingArray == Array(elements)
  }
}

//MARK: Collection
public extension BackedByArray {
  subscript(index: Int) -> BackingArrayElement {
    return backingArray[index]
  }
  
  var endIndex: Int {
    return backingArray.endIndex
  }
  
  var startIndex: Int {
    return backingArray.startIndex
  }
  
  func index(after index: Int) -> Int {
    return backingArray.index(after: index)
  }
}
