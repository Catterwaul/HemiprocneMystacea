public struct SortedArray<Element: Equatable> {
	public typealias GetAreInIncreasingOrder =
		(Element, Element) -> Bool
  
  public private(set) var backingArray: [Element]

  private let getAreInIncreasingOrder: GetAreInIncreasingOrder
}

//MARK: public
public extension SortedArray {
  static func == <Elements: Sequence>(
    backedByArray: SortedArray,
    elements: Elements
  ) -> Bool
    where Elements.Element == Element {
      return backedByArray.backingArray == Array(elements)
  }

  static func + <Elements: Sequence>(
    sortedArray: SortedArray,
    elements: Elements
  ) -> SortedArray
  where Elements.Element == Element {
    return SortedArray(
      sortedArray.backingArray + elements,
      getAreInIncreasingOrder: sortedArray.getAreInIncreasingOrder
    )
  }

  static func += (
    backedByArray: inout SortedArray,
    array: [Element]
  ) {
    backedByArray = backedByArray + array
  }

  static func - (
    sortedArray: SortedArray,
    element: Element
  ) -> SortedArray {
    return SortedArray(
      sortedArray.backingArray.filter { $0 != element },
      getAreInIncreasingOrder: sortedArray.getAreInIncreasingOrder
    )
  }

  static func -= (
    backedByArray: inout SortedArray,
    element: Element
  ) {
    backedByArray = backedByArray - element
  }

  init<Elements: Sequence>(
    _ elements: Elements,
    getAreInIncreasingOrder: @escaping GetAreInIncreasingOrder
  )
  where Elements.Element == Element {
    backingArray = elements.sorted(by: getAreInIncreasingOrder)
    self.getAreInIncreasingOrder = getAreInIncreasingOrder
  }
}

public extension SortedArray where Element: Comparable {
  init<Elements: Sequence>(_ elements: Elements)
  where Elements.Element == Element {
    self.init(
      elements,
      getAreInIncreasingOrder: <
    )
  }
  
  init(_ arrayLiteral: Element...) {
    self.init(arrayLiteral)
  }
}

//MARK: Collection
extension SortedArray: Collection {
  public subscript(index: Int) -> Element {
    return backingArray[index]
  }

  public var endIndex: Int {
    return backingArray.endIndex
  }

  public var startIndex: Int {
    return backingArray.startIndex
  }

  public func index(after index: Int) -> Int {
    return backingArray.index(after: index)
  }
}

//MARK: Sequence
public extension SortedArray {
	func min() -> Element? {
		return backingArray.first
	}
	
	func max() -> Element? {
		return backingArray.last
	}
}
